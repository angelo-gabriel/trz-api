class Inventory < ApplicationRecord
  belongs_to :survivor
  has_many :items, dependent: :destroy

  validates :survivor, presence: true, uniqueness: true
end
