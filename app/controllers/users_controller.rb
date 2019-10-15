# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    binding.pry
    @bookmarks = current_user.videos
    if current_user.github_token
      facade = UserFacade.new(current_user)
      @repos = facade.format_repos(5)
      @followers = facade.format_followers
      @following = facade.format_following
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
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
