class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: "User Name Will Go Here <#{user.email}>", subject: "Wly Big Budget Registration Confirmation")
  end
end
