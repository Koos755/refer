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
      flash.now[:error] = "You have an auto-assigned password. <a href='#{set_password_url}'>Change it here</a> to make signing in easier.".html_safe
    end
  end

  helper_method :current_user
end
