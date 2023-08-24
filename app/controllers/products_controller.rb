class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @bookmark = Bookmark.new
    @products = Product.all
    if params[:query].present?
      sql_subquery = <<~SQL
      products.name ILIKE :query
      OR products.description ILIKE :query
      OR products.category ILIKE :query
      OR users.username ILIKE :query
      SQL
      @products = @products.joins(:user).where(sql_subquery, query: "%#{params[:query]}%")
    end

    # For bootstrap layout
    per_page = 9
    total_products = @products.count
    @total_pages = (total_products.to_f / per_page).ceil
    @current_page = params[:page].to_i
    @current_page = 1 if @current_page <= 0
    @current_page = @total_pages if @current_page > @total_pages
    offset = (per_page * (@current_page - 1)).clamp(0, total_products)
    @products = @products.limit(per_page).offset(offset)
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
    # Deleting all previous photos stored in the cloud
    @product.photos.each(&:purge) if @product.photos.attached?

    # Normal Crud Action
    if @product.update(product_params)
      redirect_to product_path(@product), notice: 'Removed product from favorites list!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def my_products
    if !current_user
      # Render 401 if user is not logged_in
      render file: 'public/401.html', status: :unauthorized unless current_user
    else
      # Else show all products of the current user
      @products = current_user.products
    end
  end

  def destroy
    # A user can only destroy a product if he/she is the creator and is logged-in
    if !current_user
      render file: 'public/401.html', status: :unauthorized
      return
    elsif @product.user != current_user
      flash.now[:alert] = 'You are not the owner of this product'
      return
    end
    @product.photos.each(&:purge) if @product.photos.attached?
    @product.destroy
    redirect_to my_products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :category, :price, :description, photos: [])
  end
end
