class CartItem < ApplicationRecord
 belongs_to :customer
 belongs_to :item
  
 def total_price
  item.without_tax_price * quantity
 end
end