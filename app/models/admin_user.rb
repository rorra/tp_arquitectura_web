class AdminUser < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  rails_admin do
    # Admin-specific configurations here
  end
end
