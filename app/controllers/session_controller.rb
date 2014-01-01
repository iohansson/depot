class SessionController < ApplicationController
  skip_before_filter :authorize
  def new
    @no_users = User.count.zero?
  end

  def create
    if User.count.zero?
      user = User.create(name: params[:name], password: params[:password], password_confirmation: params[:password_confirmation])
    else
      user = User.find_by_name(params[:name])
    end
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: 'Looged out'
  end
end
