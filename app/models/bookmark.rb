class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates_uniqueness_of :product, scope: :user
end
