class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :delivery_addresses, dependent: :destroy

  validates :last_name, presence:true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true, length: {maximum: 7, minimum: 7}, numericality: true
  validates :address, presence: true
  validates :telephone_number, presence: true, length: {maximum: 11, minimum: 10}, numericality: true
  validates :email, uniqueness: true

# ユーザーアカウントが認証可能か確認コード
  # def active_for_authentication?
  #   super && (self.is_deleted == false)
  # end
  
end