class Product < ApplicationRecord
  belongs_to :user
  has_many :carts

  validates :name, :category, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
end
