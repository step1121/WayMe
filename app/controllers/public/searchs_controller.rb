class Public::SearchsController < ApplicationController
  before_action :authenticate_user!

  # ユーザー検索
  def search_user
    @content = params[:content]
    @records = User.search_for(@content)
  end

  # ビジョン検索
  def search_vision
    @content = params[:content]
    @records = Vision.search_for(@content)
    # 退会済みユーザーの投稿を除去
    users = User.no_outcheck
    # 相互フォローのユーザーID,自分のID取得
    users_follows = users.joins(:visions).where(id: current_user.followings.ids).where(id: current_user.followers.ids).or(users.where(id: current_user.id))
    # 非公開Vision_ID取得
    vision_on_private = @records.on_private
    # 公開Vision_ID取得
    vision_no_private = @records.no_private
    # 入会中　公開、相互フォローの非公開　Vision_IDの取得
    visions = vision_on_private.where(user_id: users_follows.ids).or(vision_no_private.where(user_id: users.ids)).order(created_at: :desc)
    # 未達成VISION
    @visions_still = visions.still
    # 達成VISION
    @visions_finish = visions.finish
  end
end
