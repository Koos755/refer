class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :auto_password_check

  def current_user
    return User.find_by(:id => session[:user_id])
  end

  def auto_password_check
    if current_user.present? && current_user.auto_password
      flash[:error] = "You still have the auto assigned password, <a href='#{set_password_url}'>Click Here</a> to change".html_safe
    end
  end

  helper_method :current_user
end
