# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @tutorials = Tutorial.all
    if current_user.github_token
      @facade = UserFacade.new(current_user)
      @git_friends = current_user.friends
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      user.set_confirmation_token
      user.save(validate: false)
      UserMailer.registration_confirmation(user).deliver_now!
      flash[:success] = "Logged in as #{user.first_name}"
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:token])
    if user
      user.validate_email
      user.save(validate: false)
      flash[:success] = "Thank you! Your account is now active."
      redirect_to dashboard_path
    else
      flash[:error] = "Oops, something went wrong."
      redirect_to dashboard_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
