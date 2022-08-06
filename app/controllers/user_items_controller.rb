class UserItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound,
    with: :not_logged_in

  def index
    @user = User.find(session[:user_id])
  end

  private
  def not_logged_in
    flash[:error] = 'you must be logged in to view that page'
    redirect_to '/'
  end
end
