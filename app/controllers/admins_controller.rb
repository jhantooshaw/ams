class AdminsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    
  end
  
  def login
    render layout: "welcome"
  end
end
