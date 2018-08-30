class UsersController < SessionsController
  def confirm_email
    render html: "We are gonna confirm the email here!"
  end

  def show
    unless logged_in? && this_user?
      redirect_to root_path and return
    end

    @user = User.find(params[:id])
  end

  def new
    if logged_in?
      @user = User.find(session[:user_id])
      redirect_to @user
    else
      @user = User.new
    end
  end

  def create
    if logged_in?
      @user = User.find(session[:user_id])
      redirect_to @user and return
    end

    @user = User.find_by(email: authentication_params[:email])
    if authenticated?
      log_in and return
    # add an else to handle a user who has been authenticated but not confirmed
    elsif @user
      redirect_to new_user_path, notice: "This email is taken; please use another" and return
    end

    @user = User.new(authentication_params)
    if @user.save
      # based on https://coderwall.com/p/u56rra/ruby-on-rails-user-signup-email-confirmation-tutorial
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = "Please confirm your email address to continue"
      redirect_to root_url
    else
      redirect_to new_user_path, notice: "Invalid email or password, please try again" and return
    end
  end
end
