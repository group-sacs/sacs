class CartItem < ApplicationRecord
 belongs_to :customer#has_many :cart_items customerはまだやってなくりゅーじさんに確認
 belongs_to :item
  
 def total_price
  item.without_tax_price * quantity
 end
end