class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to take this action"
    redirect_to home_path
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end

      @state_array = ['Alabama', 
'Alaska', 
'Arizona', 
'Arkansas', 
'California', 
'Colorado', 
'Connecticut', 
'Delaware', 
'District of Columbia', 
'Florida', 
'Georgia', 
'Hawaii', 
'Idaho', 
'Illinois', 
'Indiana', 
'Iowa', 
'Kansas', 
'Kentucky', 
'Louisiana', 
'Maine', 
'Maryland', 
'Massachusetts', 
'Michigan', 
'Minnesota', 
'Mississippi', 
'Missouri', 
'Montana', 
'Nebraska', 
'Nevada', 
'New Hampshire', 
'New Jersey', 
'New Mexico', 
'New York', 
'North Carolina', 
'North Dakota', 
'Ohio', 
'Oklahoma', 
'Oregon', 
'Pennsylvania', 
'Puerto Rico',
'Rhode Island', 
'South Carolina', 
'South Dakota', 
'Tennessee', 
'Texas', 
'Utah', 
'Vermont', 
'Virginia', 
'Washington', 
'West Virginia', 
'Wisconsin', 
'Wyoming' ]
end
