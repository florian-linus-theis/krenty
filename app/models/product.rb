class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  validates :price, presence: true
  validates :name, presence: true
  validates :photos, presence: true

  # Checks if category is one of the following allowed categories
  ALLOWED = [
    'electronics',
    'furniture',
    'books',
    'clothing',
    'children supplies',
    'accessories',
  ]
  validates :category, presence: true, inclusion: { in: ALLOWED}
end
