class Api::V1::ProductsController < ActionController::API

  def index
    @products = Product.select(:id, :title, :discounted_price, :normal_price, :raitings_reviews, :raitings_average, :image_links)
  
    render json: @products.as_json(only: [:id, :title, :discounted_price, :normal_price, :raitings_reviews, :raitings_average, :image_links])
  end
  
  def show
    @product = Product.find(params[:id])
    render json: ProductSerializer.new(@product).serializable_hash
  end

  def create
    scrapper = ScrapperService.new(params[:url])
    product_data = scrapper.scrape_and_save

    if product_data[:error]
      render json: { error: product_data[:error] }, status: :unprocessable_entity
    else
      product = Product.new(product_data)
      
      if product.save
        render json: ProductSerializer.new(product).serializable_hash, status: :created
      else
        render json: product.errors, status: :unprocessable_entity
      end
    end
  end
end