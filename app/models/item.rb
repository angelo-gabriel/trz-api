class Item < ApplicationRecord
  belongs_to :inventory

  validates :inventory, presence: true
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :name, uniqueness: { scope: :inventory_id, message: "Item already exists in this inventory" }
end
