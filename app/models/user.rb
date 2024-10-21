class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :carts
  has_many :orders

  validates :name, presence: true

  def current_cart
    carts.find_or_create_by(status: 'pending')
  end
end
