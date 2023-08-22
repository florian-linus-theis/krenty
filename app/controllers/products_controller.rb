class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Cloudinary::Uploader.destroy("development/#{current_user.photo.key}")
    # Deleting all previous photos stored in the cloud
    if @product.photos.attached?
      @product.photos.each { |photo| photo.purge }
    end

    # Normal crud action
    @product.update(product_params)
    redirect_to product_path(@product)
  end

  def destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :category, :price, :description, photos: [])
  end
end
