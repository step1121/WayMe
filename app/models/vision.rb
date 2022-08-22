class Vision < ApplicationRecord
  has_one_attached :production
  belongs_to :user
  belongs_to :genre
  has_many :tasks, dependent: :destroy

  validates :title, length: { minimum: 2, maximum: 20 }, presence: true
  validates :body, length: { maximum: 100 }
  validates :finish_on, presence: true

  scope :still, -> { where(finish_status: false) }
  scope :finish, -> { where(finish_status: true) }
  

  def self.search_for(content)
    Vision.where(['title LIKE ? OR body LIKE ?', "%#{content}%","%#{content}%"])
  end

end
