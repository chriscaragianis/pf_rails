class WelcomeController < ApplicationController
  def index
  end

  def setup
    render "accounts/new"
  end
end
