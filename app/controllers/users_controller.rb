class UsersController < ApplicationController
  def index
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
    flash[:success] = "Profile destroyed succesfully!"
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)

    end
end
