class Public::UsersController < ApplicationController
  before_action :authenticate_customer!
  
  def edit
  end

  def show    
    @user = User.find(params[:id])
  end

  def out_check
  end
  
  def update
  end
  
  def out_check
  end
  
  def out
  end

  def user_params
    params.require(:user).permit(:name, :birthday, :biography)
  end
end
