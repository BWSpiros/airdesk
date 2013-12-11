module ApplicationHelper
  def current_user
    User.find_by_session(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def auth
    "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}' >".html_safe
  end

end
