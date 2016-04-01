class WelcomeController < ApplicationController
  def index
    if !current_user.nil? then
      redirect_to "/dashboard"
    end
  end

  def setup
    render "accounts/new"
  end
end
