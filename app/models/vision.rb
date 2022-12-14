class Vision < ApplicationRecord
  
  has_one_attached :production_image
  
  belongs_to :user
  belongs_to :genre
  has_many :tasks, dependent: :destroy
  has_many :fights, dependent: :destroy
  has_many :vision_comments, dependent: :destroy

  validates :title, length: { minimum: 2, maximum: 20 }, presence: true
  validates :body, length: { maximum: 100 }
  validates :finish_on, presence: true
  validate :dae_before_start

  enum release_status: { public: 0, private: 1 }, _prefix: true

  scope :still, -> { where(finish_status: false) }
  scope :finish, -> { where(finish_status: true) }
  scope :no_private, -> { where(release_status: false) }
  scope :on_private, -> { where(release_status: true) }
  
  # ビジョン検索方法
  def self.search_for(content)
    Vision.where(['title LIKE ? OR body LIKE ?', "%#{content}%","%#{content}%"])
  end

  # ビジョンの達成日のバリデーション
  def dae_before_start
    return if finish_on.blank?
    errors.add(:finish_on, "は本日以降を選択してください") if finish_on < Date.today
  end

  def get_production_image
    if production_image.attached?
      production_image
    else
      'no_production_image.jpg'
    end
  end

end