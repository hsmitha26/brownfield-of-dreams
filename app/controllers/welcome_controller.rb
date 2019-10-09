# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    welcome = WelcomeFacade.new
    if current_user
      @tutorials = welcome.all_tutorials(params[:page], params[:tag])
    else
      @tutorials = welcome.visitor_tutorials(params[:page], params[:tag])
    end
  end
end
