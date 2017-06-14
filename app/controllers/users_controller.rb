class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy

  def index
    @users = User.select(:id, :name, :email).order(id: :asc).paginate page: params[:page],
      per_page: Settings.paginate.size
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".email_activated"
      redirect_to root_url
    else
      flash[:warning] = t ".signup_error"
      render :new
    end
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page],
      per_page: Settings.paginate.size
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete"
      redirect_to users_url
    else
      flash[:warning] = t ".error_delete"
      redirect_to users_url
    end
  end

  def following
    @title = t "following"
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.paginate.size
    render "show_follow"
  end

  def followers
    @title = t ".follower"
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.paginate.size
    render "show_follow"
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:warning] = t ".not_found"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".login_first"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]

    redirect_to root_url unless @user.compare_user current_user
  end

  def verify_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
