class SessionsController < ApplicationController
  skip_before_filter :login_required, :except => "destroy"

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      render "new", :notice => "Email or password is invalid"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end