class SessionsController < ApplicationController
  skip_before_filter :check_logged_in, only: [:create,:new]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if !@user.nil?
      session[:token] = @user.reset_token
      @user.update_attribute(:ip_address, request.remote_ip)
      redirect_to root_url
    else
      flash[:errors] = "Invalid Login"
      @user = User.new(params[:user])
      @user.geocode
      render :new
    end
  end


  def destroy
    current_user.reset_token
    session[:token] = nil
    redirect_to new_session_url
  end

end
