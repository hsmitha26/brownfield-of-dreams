class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.first_name} <#{user.email}>", subject: "Brownfield Registration Confirmation")
  end
end
