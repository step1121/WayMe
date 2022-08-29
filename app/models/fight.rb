class Fight < ApplicationRecord
  belongs_to :user
  belongs_to :vision

  validates_uniqueness_of :vision_id, scope: :user_id
end
