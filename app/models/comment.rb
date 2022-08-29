class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :vision
  validates :comment, presence: true, length: { maximum: 100 }
end
