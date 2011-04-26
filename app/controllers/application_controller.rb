class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_admin  

  private  
  def current_admin_session  
    return @current_admin_session if defined?(@current_admin_session)  
    @current_admin_session = AdminSession.find  
  end  

  def current_admin
    @current_admin = current_admin_session && current_admin_session.record  
  end
  
end
