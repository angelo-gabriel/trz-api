class Item < ApplicationRecord
  belongs_to :inventory

  validates :inventory, presence: true
end
