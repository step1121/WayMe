class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, except: [:index]

  def index
    @users = User.all
  end

  def show
    @visions = @user.visions.order(finish_on: "ASC")
  end


  def out
    @user.update(user_status: true)
    reset_session
    redirect_to admin_users_path
  end


  private

  def ensure_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_status)
  end
end

