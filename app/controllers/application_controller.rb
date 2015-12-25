class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :check_if_authenticated

  def check_if_authenticated
    unless controller_name == 'users' and %w(authenticate sign_in exit).include? action_name
      session[:controller_back] = controller_name
      session[:action_back] = action_name
    end
    if session[:authenticated]
      return true
    else
      flash[:error] = 'Доступ запрещен'
      render 'users/sign_in', status: :forbidden
    end
  end
end