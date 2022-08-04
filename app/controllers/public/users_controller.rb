class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, except: [:show]
  
  
  def edit
  end

  def show    
    @user = User.find(params[:id])
    @visions = @user.visions
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
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
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :birthday, :biography)
  end
end
