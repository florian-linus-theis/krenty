class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.where(user: current_user)
  end

  def create
    unless current_user.present?
      flash.now[:error] = 'Please login to add this product to your favorites list!'
      return
    end
    @bookmark = Bookmark.new
    @bookmark.product = Product.find(params[:bookmark][:product])
    @bookmark.user = current_user
    if @bookmark.save
      redirect_back fallback_location: root_path, alert: 'Added product to your favorites list!'
    else
      redirect_back fallback_location: root_path, alert: 'Oops somethig went wrong!'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      redirect_back fallback_location: root_path, notice: 'Removed product from favorites list!'
    else
      redirect_back fallback_location: root_path, alert: 'Oops somethig went wrong!'
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:product)
  end
end
