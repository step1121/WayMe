class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def index
    user = User.find(params[:user_id])
    # フォロー一覧
    @users_followings = user.followings
    # フォローワー一覧
    @users_followers = user.followers
  end
end
