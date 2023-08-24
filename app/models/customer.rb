class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 下記追記した
  has_many :orders, dependent: :destroy
  # 下記追記した
  has_many :cart_items, dependent: :destroy
end