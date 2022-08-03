class Vision < ApplicationRecord
    has_one_attached :production
    belongs_to :user
    belongs_to :genre
    has_many :tasks
    
    validates :title, length: { minimum: 2, maximum: 20 }, presence: true
    validates :body, length: { maximum: 100 }
    validates :date, presence: true
end
