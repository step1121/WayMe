class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user
  
  
  def edit
  end

  def show    
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_user_path
    else
      render :edit
    end
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
    params.require(:user).permit(:name, :birthday, :biography)
  end
end
