class Survivor < ApplicationRecord
  has_one :inventory, dependent: :destroy
  has_many :items, through: :inventory

  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  enum :gender, { male: 0, female: 1 }
  validates :gender, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
end
