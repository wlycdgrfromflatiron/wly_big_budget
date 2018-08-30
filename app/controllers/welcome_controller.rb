class WelcomeController < SessionsController
  def home
    if logged_in?
      @user = User.find(session[:user_id])
      redirect_to @user
    end

    @user = User.new
  end
end
