class Genre < ApplicationRecord
  has_many :visions

  validates :name, presence: true, uniqueness: true
end
