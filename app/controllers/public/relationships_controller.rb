class Public::RelationshipsController < ApplicationController

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
  # フォロー一覧
  def index
    user = User.find(params[:user_id])
    @users_followings = user.followings
    @users_followers = user.followers
  end
end
