class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.where(user_id: current_user.id)
  end

  def create
    @purchase = Purchase.new
    @purchase.user = current_user
    @product = Product.find(params[:product_id])
    @purchase.product = @product
    if @purchase.save
      redirect_to purchases_path
    else
      flash.now[:alert] = 'Product already in basket'
      render "products/show", product: @product, status: :unprocessable_entity
    end
  end

  def destroy
    # define

    @purchase = Purchase.find(params[:id])
    if !current_user
      render file: 'public/401.html', status: :unauthorized
      return
    end
    @purchase.destroy
    redirect_to purchases_path
  end
end
