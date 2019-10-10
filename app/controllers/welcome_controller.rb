# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    welcome = WelcomeFacade.new
    @tutorials = if current_user
                   welcome.all_tutorials(params[:page], params[:tag])
                 else
                   welcome.visitor_tutorials(params[:page], params[:tag])
                 end
  end
end
