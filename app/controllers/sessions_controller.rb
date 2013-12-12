class SessionsController < ApplicationController
  skip_before_filter :check_logged_in, only: [:create,:new]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    begin
      if @user
        session[:token] = @user.reset_token
        redirect_to root_url
      end
    rescue
      flash[:errors] = "Invalid Login"
      render :new
    else
      render :new
    end

  end

  def destroy
    current_user.reset_token
    session[:token] = nil
    redirect_to new_session_url
  end

end
