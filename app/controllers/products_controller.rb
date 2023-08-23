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
    # A user can only edit a product if he/she is the creator
    render file: 'public/401.html', status: :unauthorized unless @product.user == current_user
  end

  def update
    # Cloudinary::Uploader.destroy("development/#{current_user.photo.key}")
    # Deleting all previous photos stored in the cloud
    @product.photos.each(&:purge) if @product.photos.attached?

    # Normal crud action
    @product.update(product_params)
    redirect_to product_path(@product)
  end

  def my_products
    @products = current_user.products
  end

  def destroy
    # A user can only destroy a product if he/she is the creator
    render file: 'public/401.html', status: :unauthorized unless @product.user == current_user
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :category, :price, :description, photos: [])
  end
end
