class SessionsController < ApplicationController
  def signin
    if logged_in?
      @user = User.find(session[:user_id])
      redirect_to home_user_path(@user) and return
    end

    @user = User.find_by(email: authentication_params[:email])
    if authenticated?
      if @user.email_confirmed
        log_in and return
      else
        flash.now[:notice] = 'To start using Big Budget, please activate your account by following the instructions in the account confirmation email you received.'
        redirect_to root_path and return
      end
    else
      flash[:notice] = "Bad username and/or password."
      redirect_to root_path and return
    end
  end

  def amazon_signin
    if logged_in?
      @user = User.find(session[:user_id])
      redirect_to home_user_path(@user) and return
    end

    @user = User.find_or_create_by(amazon_user_id: omniauth['uid']) do |u|
      u.name = omniauth['info']['name']
      u.email = omniauth['info']['email']
      u.password = SecureRandom.urlsafe_base64.to_s
    end

    @user.mark_email_confirmed

    log_in
  end

  def signout
    session.delete(:user_id)
    redirect_to root_path
  end

  protected

  def omniauth
    request.env['omniauth.auth']
  end

  def authenticated?
    @user && @user.authenticate(authentication_params[:password])
  end

  def authentication_params
    params.require(:user).permit(:email, :password)
  end

  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def log_in
    session[:user_id] = @user.id
    redirect_to home_user_path(@user)
  end

  def this_user?
    session[:user_id].to_i == params[:id].to_i
  end

  def this_user_nested?
    session[:user_id].to_i == params[:user_id].to_i
  end

  def this_carts_user?
    cart = Cart.find_by(id: params[:cart_id])

    if !cart || !cart.user 
      false
    else 
      session[:user_id].to_i == cart.user.id
    end
  end

  def session_guard(isUser)
    unless logged_in? && isUser
      redirect_to root_path
    else
      @user = User.find(session[:user_id])
    end
  end
end
