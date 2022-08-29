class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :validatable,
         :database_authenticatable, authentication_keys: [:name]

  has_one_attached :profile_image

  has_many :visions
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  has_many :fights
  has_many :comments, dependent: :destroy

  scope :no_outcheck, -> { joins(:visions).where(user_status: false) }

  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }, presence: true
  validates :biography, length: { maximum: 50 }

  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      'no_image.jpeg'
    end
  end


  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(content)
    User.where(['name LIKE ?', "%#{content}%"])
  end

  def fighted_by?(vision_id)
    fights.where(vision_id: vision_id).exists?
  end

end
