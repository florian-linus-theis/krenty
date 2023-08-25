class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :purchases, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_one_attached :photo
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  before_destroy :delete_old_photo

  private

  def delete_old_photo
    photo.purge if photo.attached?
  end
end
