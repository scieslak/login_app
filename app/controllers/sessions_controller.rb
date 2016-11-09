class SessionsController < ApplicationController
  def new
    # display log in form
  end

  def create
    user = User.find_by_username(params[:username])
    user ||= User.find_by_email(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "I have been succesfully logged in."
      redirect_to user
    else
      flash.now[:error] = "Invalid username or email/password combination!"
      render 'new'
    end
  end


  def destroy
    session[:user_id] = nil
    reset_session
    flash[:success] = "You have been succesfully logged out."
    redirect_to root_path

  end
end