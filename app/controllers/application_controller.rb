class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  include DealsHelper

  before_filter :check_logged_in

  def check_logged_in
    redirect_to new_session_url unless logged_in?
  end

end
