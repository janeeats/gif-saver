class SessionsController < ApplicationController
  skip_before_filter :login_required, :except => "destroy"

  def new
    render :layout => 'layouts/login'
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_gifs_path(user), :notice => "Logged in!"
    else
      render "new", :notice => "Email or password is invalid"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to log_in_path, :notice => "Logged out!"
  end

  def twitter
    auth = request.env['omniauth.auth']
    unless @auth = Identity.find_from_hash(auth)
      # create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Identity.create_from_hash_for_twitter(auth, current_user)
    end

    # Log the authorizing user in.
    # current_user = @auth.user
    redirect_to user_gifs_path(current_user), :notice => "Yay! Your account is connected to your Twitter, #{current_user.username}."
  end

  def facebook
    auth = request.env['omniauth.auth']
    unless @auth = Identity.find_from_hash(auth)
      # create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Identity.create_from_hash(auth, current_user)
    end

    # Log the authorizing user in.
    # current_user = @auth.user
    redirect_to user_gifs_path(current_user), :notice => "Yay! Your account is connected to your Facebook, #{current_user.username}."
  end
  
end