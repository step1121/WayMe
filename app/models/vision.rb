class Vision < ApplicationRecord
  has_one_attached :production
  belongs_to :user
  belongs_to :genre
  has_many :tasks, dependent: :destroy
  
  validates :title, length: { minimum: 2, maximum: 20 }, presence: true
  validates :body, length: { maximum: 100 }
  validates :finish_on, presence: true
  
  def self.search_for(content)
    Vision.where(['title LIKE ? OR body LIKE ?', "%#{content}%","%#{content}%"])
  end
  
  # def task_complete_count
  #   @tasks = Vision.where{tasks(completion_status: true)}
  #   @task_complete = @tasks.count
  # end
  
  # def task_still_count
  #   @tasks = Vision.where(task_completion_status: false)
  #   @task_still = @tasks.counts
  # end
  
  # def task_count
  #   @tasks = Vision.Tasks.all
  # end
end
