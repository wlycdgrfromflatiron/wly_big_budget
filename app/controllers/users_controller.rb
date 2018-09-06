class UsersController < SessionsController
  # parameterized filter implementation adapted from:
  # https://stackoverflow.com/questions/5507026/before-filter-with-parameters
  before_action only: [:home, :show] {|c| c.session_guard c.this_user? }

  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      @user.mark_email_confirmed
      log_in
    else
      redirect_to root_url, notice: "Used or invalid token."
    end
  end

  def home
  end

  def show
    redirect_to home_user_path
  end

  def new
    if logged_in?
      @user = User.find(session[:user_id])
      redirect_to home_user_path(@user)
    else
      @user = User.new
    end
  end

  def create
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
