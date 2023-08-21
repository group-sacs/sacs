class CartItem < ApplicationRecord
 belongs_to :customer#has_many :cart_items customerはまだやってなくりゅーじさんに確認
  belongs_to :item
end