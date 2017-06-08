class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t ".not_found"
    redirect_to root_url
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t ".signup_success"
      redirect_to @user
    else
      flash[:warning] = t ".signup_error"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
