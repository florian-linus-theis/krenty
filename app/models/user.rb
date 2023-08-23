class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :purchases
  has_many :products
  has_one_attached :photo
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  # before_update :delete_old_photo
  # before_destroy :delete_old_photo

  private

  def delete_old_photo
    self.photo.purge if self.photo.attached?
  end

end
