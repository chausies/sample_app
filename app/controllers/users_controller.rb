class UsersController < ApplicationController

  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.reorder(:id).paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
    	flash[:success] = "Welcome to the Sample app!"
      	redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if !current_user.admin?
      sign_out
      User.find(params[:id]).destroy
      flash[:success] = "Account successfully deleted. We'll miss you T~T <3"
      redirect_to root_url
    else
      User.find(params[:id]).destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url, notice: "You ain't allowed to edit other users ಠ_ಠ" unless current_user?(@user)
    end

    def admin_user
      unless current_user.admin? || current_user?(User.find(params[:id]))
        redirect_to root_url, notice: "What're you trying to pull? Only rela admins can delete other users ಠ_ಠ"
      end
    end
end
