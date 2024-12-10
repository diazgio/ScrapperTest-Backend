class Product < ApplicationRecord
  validates :image_links, length: { maximum: 10 }
end
