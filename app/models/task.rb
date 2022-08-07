class Task < ApplicationRecord
  belongs_to :vision
        
  validates :content, length: { minimum: 2, maximum: 30 }, presence: true
  validates :completion_on, presence: true
    
end
