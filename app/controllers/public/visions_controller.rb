class Public::VisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_vision, only: [:show, :edit, :update, :destroy]
  before_action :baria_user, only: [:edit, :update, :destroy]


  def new
    @vision = Vision.new
  end

  def create
    @vision = Vision.new(vision_params)
    @vision.user_id = current_user.id
    @vision.save ? (redirect_to visions_path) : (render :new)
  end

  def index
    # 退会済みユーザーの投稿を除去
    users = User.no_outcheck
    # 相互フォローのユーザーID,自分のID取得
    users_follows = users.joins(:visions).where(id: current_user.followings.ids).where(id: current_user.followers.ids).or(users.where(id: current_user.id))
    # 非公開Vision_ID取得
    vision_on_private = Vision.on_private
    # 公開Vision_ID取得
    vision_no_private = Vision.no_private
    # 入会中　公開、相互フォローの非公開　Vision_IDの取得
    visions = vision_on_private.where(user_id: users_follows.ids).or(vision_no_private.where(user_id: users.ids)).order(created_at: :desc)
    # ジャンル検索時
    genre_visions = visions.where(genre_id: params[:genre_id]).order(created_at: :desc)
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      visions = genre_visions.all
    end

    # 未達成VISION
    @visions_still = visions.still
    # 達成VISION
    @visions_finish = visions.finish
  end

  def show
    @tasks = @vision.tasks.order(completion_on: "ASC")
    # 未完了TASK
    @tasks_yet = @tasks.yet
    # 完了TASK
    @tasks_complete =@tasks.complete
    @task = Task.new
  end

  def edit
  end

  def update
    @vision.update(vision_params) ? (redirect_to vision_path(@vision)) : (render :edit)
  end

  def destroy
    @vision.delete
    redirect_to user_path(current_user)
  end


  private

  def vision_params
    params.require(:vision).permit(:title, :body, :finish_on, :genre_id, :finish_status, :production, :release_status)
  end

  def ensure_vision
    @vision = Vision.find(params[:id])
  end

  def baria_user
    unless Vision.find(params[:id]).user.id == current_user.id
        redirect_to visions_path
    end
  end
end
