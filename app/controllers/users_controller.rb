class UsersController < ApplicationController
  def new; end
  def create
    user = User.new(user_params)

    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to '/items'
    else
      flash[:error] = 'invalid credentials'
      redirect_to '/'
    end
  end

  private

  def user_params
    params.permit(
      :email,
      :password, 
      :password_confirmation
    )
  end
end
