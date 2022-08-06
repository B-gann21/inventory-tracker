class UserItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound,
    with: :not_logged_in

  def index
    user = User.find(session[:user_id])

    if params[:sort_by_cat]
      @items = user.items_by_category
    else
      @items = user.items_by_updated
    end
  end

  private
  def not_logged_in
    flash[:error] = 'you must be logged in to view that page'
    redirect_to '/'
  end
end
