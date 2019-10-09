# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if current_user
      @tutorials = all_tutorials
    else
      @tutorials = visitor_tutorials
    end
  end

  private

  def all_tutorials
    if params[:tag]
      Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end

  def visitor_tutorials
    if params[:tag]
      Tutorial.where(classroom: false).tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      Tutorial.where(classroom: false).paginate(page: params[:page], per_page: 5)
    end
  end
end
