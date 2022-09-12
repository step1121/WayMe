class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_current_user, except: [:show, :index]

  # サインイン時のエラーの際のダミールート
  def index
    redirect_to "/users/sign_up"
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    # 相互フォローしている又は自分のuser_IDを取得
    if @user == current_user || current_user.following?(@user) && @user.following?(current_user)
      visions = @user.visions.order(created_at: :desc)
    else
      # 公開Vision_IDを取得
      vision_no_private = Vision.no_private
      visions = vision_no_private.where(user_id: @user)
    end
    # 未達成VISIONの全IDの格納
    @visions_still = visions.still
    # 達成VISIONの全IDの格納
    @visions_finish = visions.finish
  end

  def update
    if @user.update(user_params)
      # S3への画像反映のタイムラグを考慮して3秒待機
      sleep(3)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

# 　退会時のページ取得
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
    params.require(:user).permit(:name, :email, :birthday, :biography, :profile_image, :user_status)
  end
end