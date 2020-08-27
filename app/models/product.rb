class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :carts
  has_one_attached :photo

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
end
