class WelcomeController < ApplicationController
  def index
    if !current_user.nil? then
      render "/welcome/index.html"
    end
  end

  def setup
    render "accounts/new"
  end
end
