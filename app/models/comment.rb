class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :travel_record
  validates :comment, presence: true, length: { maximum: 100 }
end
