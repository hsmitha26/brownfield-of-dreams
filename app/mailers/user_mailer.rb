class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.first_name} <#{user.email}>", subject: "Brownfield Registration Confirmation")
  end

  def invitation(user, invited_user)
    @user = user
    @invited_user = invited_user
    mail(to: "#{invited_user['email']}", subject: "#{user.first_name} has sent you an invite!")
  end
end
