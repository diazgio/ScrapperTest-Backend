class ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :size_tag, :discounted_price, :normal_price, :discount, :raitings_reviews, :raitings_average, :image_links

  attribute :clean_product_details do |object|
    object.product_details.map do |detail|
      eval(detail)
    end
  end
end