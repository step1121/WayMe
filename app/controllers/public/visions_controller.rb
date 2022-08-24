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
    @vision_no_private = Vision.no_private
    # @vision_no_private = Vision.where(user_id: current_user)
    @visions = @vision_no_private.where(user_id: users.ids).order(created_at: :desc)
    # || Vision.on_private && (current_user.followed_by? @vision.user) && (@vision.user.followed_by? current_user)
    # ジャンル検索時
    @all_visions = @visions.where(genre_id: params[:genre_id]).order(created_at: :desc)
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @visions = @all_visions.all
    end

    # 未達成VISION
    @visions_still = @visions.still
    # 達成VISION
    @visions_finish = @visions.finish
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
