class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, except: [:show]


  def edit
  end

  def show
    @user = User.find(params[:id])
    @visions = @user.visions.order(finish_on: "ASC")
  end

  def update
    @user.update(user_params) ? (redirect_to user_path) : (render :edit)
  end

  def out_check
  end

  def out
    @user.update(user_status: true)
    reset_session
    redirect_to root_path
  end


  private

  def set_current_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :birthday, :biography, :profile_image, :user_status)
  end
end
