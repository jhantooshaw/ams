class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout
    
    
  private 
  def set_layout
    if devise_controller?
      'welcome'    
    end
  end

end
