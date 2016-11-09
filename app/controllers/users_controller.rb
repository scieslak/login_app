class UsersController < ApplicationController

  before_action :authorized_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Profile created succesfully!"
      redirect_to @user
    else
      flash.now[:error] = "We had a problem to process submited form!"
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated succesfully!"
      redirect_to @user
    else
      flash.now[:error] = "We had a problem to process submited form!"
      render 'edit'
    end

  end

  def delete
    @user = User.find_by_id(params[:id])
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    log_out
    flash[:success] = "Profile destroyed succesfully!"
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end


    def authorized_user
      if !logged_in?
        flash[:error] = "ACCESS DENIED! PLEASE LOG IN!"
        redirect_to login_path

      elsif params[:id].to_i != current_user.id
        flash[:error] = "ACCESS DENIED! NO PERMITION TO ACCES THIS PROFILE"
        redirect_to root_path
      end
    end

    # def authorized_user
    #   unless params[:id] == current_user.id
    #     flash[:error] = "ACCESS DENIED! PLEASE LOG IN!"
    #     redirect_to login_path
    #   end
    # end
end
