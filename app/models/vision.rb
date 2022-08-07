class Vision < ApplicationRecord
  has_one_attached :production
  belongs_to :user
  belongs_to :genre
  has_many :tasks
  
  validates :title, length: { minimum: 2, maximum: 20 }, presence: true
  validates :body, length: { maximum: 100 }
  validates :finish_on, presence: true
  
  def are_all_tasks_completed?
    (tasks.true.count == tasks.count) ? true : false
  end
  
  # def self.search(keyword)
  #   where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  # end
end
