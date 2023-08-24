class Item < ApplicationRecord
 belongs_to :genre
 has_many :cart_items
 has_many :order_details
  with_options presence: true do
   validates :name
   validates :explamatory_text
   validates :without_tax_price

   # validates :stock
   validates :image
 end

 has_one_attached :image
# 下記追記した
 def add_tax_without_tax_price
  (self.without_tax_price * 1.10).round
 end

end