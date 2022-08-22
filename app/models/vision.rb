class Vision < ApplicationRecord
  has_one_attached :production
  belongs_to :user
  belongs_to :genre
  has_many :tasks, dependent: :destroy

  validates :title, length: { minimum: 2, maximum: 20 }, presence: true
  validates :body, length: { maximum: 100 }
  validates :finish_on, presence: true
  enum release_status: { public: 0, private: 1 }, _prefix: true

  scope :still, -> { where(finish_status: false) }
  scope :finish, -> { where(finish_status: true) }
  scope :no_private, -> { where(release_status: true) }
  scope :on_private, -> { where(release_status: false) }



  def self.search_for(content)
    Vision.where(['title LIKE ? OR body LIKE ?', "%#{content}%","%#{content}%"])
  end

end
