class WelcomeController < ApplicationController
  def index
  end

  def setup
    Account.delete_all
    render "accounts/new"
  end
end
