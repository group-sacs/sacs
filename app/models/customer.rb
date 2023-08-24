class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :cart_items
  has_many :delivery_addresses

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + last_name + ' ' + first_name
  end
end