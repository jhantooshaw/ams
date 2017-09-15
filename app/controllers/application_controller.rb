class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout
  before_action :get_active
    
    
  private 
  def set_layout
    if devise_controller?
      'welcome'    
    end
  end
  
  def get_user
    @user = current_user
  end
  
  def get_active
    case params[:controller]
    when 'admins'
      @admin_active = 'active'
    when 'contacts'
      @contact_active = 'active'
    when 'fund_transfers'
      @fund_active = 'active'
    end
  end

end
