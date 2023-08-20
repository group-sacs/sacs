class Item < ApplicationRecord
 belongs_to :genre
 
  with_options presence: true do
   validates :name
   validates :description
   validates :price
   validates :stock
   validates :image
 end
 has_one_attached :image
end