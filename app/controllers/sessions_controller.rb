class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/items'
    else
      flash[:error] = 'invalid credentials'
      redirect_to '/sessions/new'
    end
  end

  def destroy
    session.destroy
    redirect_to '/'
  end
end
