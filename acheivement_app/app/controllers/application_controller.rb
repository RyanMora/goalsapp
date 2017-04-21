class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :auth_token

  def login(user)
    user.reset_session_token
    session[:session_token] = user.session_token
  end

  def logout
    if current_user
      current_user.reset_session_token
      session[:session_token] = nil
    end
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def auth_token
    "<input type='hidden' name='authenticity_token' value=#{form_authenticity_token}>".html_safe
  end
end
