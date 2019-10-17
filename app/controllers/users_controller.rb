# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @facade = UserFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      send_confirmation_email(user)
      flash[:success] = "Logged in as #{user.first_name}."
      redirect_to dashboard_path
    else
      flash[:error] = 'Please complete all fields on the form.'
      redirect_to new_user_path
    end
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:token])
    if user
      user.validate_email
      user.save(validate: false)
      flash[:success] = 'Thank you! Your account is now active.'
    else
      flash[:error] = 'Oops, something went wrong.'
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def send_confirmation_email(user)
    user.set_confirmation_token
    user.save(validate: false)
    UserMailer.registration_confirmation(user).deliver_now
  end
end
