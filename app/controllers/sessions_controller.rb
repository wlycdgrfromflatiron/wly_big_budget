class SessionsController < ApplicationController
  def signin
    if logged_in?
      @user = User.find(session[:user_id])
      redirect_to @user and return
    end

    @user = User.find_by(email: authentication_params[:email])
    if @user && @user.authenticate(authentication_params[:password])
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

  private

  def authenticated?
    @user && @user.authenticate(authentication_params[:password])
  end

  def authentication_params
    params.require(:user).permit(:email, :password)
  end

  def logged_in?
    session[:user_id]
  end

  def log_in
    session[:user_id] = @user.id
    redirect_to @user
  end

  def this_user?
    session[:user_id].to_i == params[:id].to_i
  end

  def this_user_nested?
    session[:user_id].to_i == params[:user_id].to_i
  end

  def session_guard_for_nested_resource
    unless logged_in? && this_user_nested?
      redirect_to root_path
    end
  end
end
