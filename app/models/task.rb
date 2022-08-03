class Task < ApplicationRecord
    belongs_to :vision
    
    validates :content, length: { minimum: 2, maximum: 30 }, presence: true
    validates :date, presence: true
    
end
