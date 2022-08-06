class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound,
    with: :not_logged_in

  def new; end
  def create
    user = User.find(session[:user_id])
    item = Item.new(item_params)
    item.user_id = user.id

    if item.valid?
      item.save; redirect_to '/items'
    else
      flash[:error] = 'fields can not be missing'
      redirect_to '/items'
    end
  end

  private
  def not_logged_in
    flash[:error] = 'you must be logged in to view that page'
    redirect_to '/'
  end

  def item_params
    params.permit(
      :name,
      :quantity,
      :category,
      :favorite,
      :price
    )
  end
end
