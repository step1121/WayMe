class Public::VisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_vision, only: [:show, :edit, :update, :destroy]

  def new
    @vision = Vision.new
  end

  def create
    @vision = Vision.new(vision_params)
    @vision.user_id = current_user.id
    @vision.save ? (redirect_to vision_path(@vision)) : (render :new)
  end

  def index
    @all_visions = Vision.where(genre_id: params[:genre_id])
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @visions = @all_visions.all
      @visions_still = @visions.where(finish_status: false)
      @visions_finish = @visions.where(finish_status: true)
    else
      users = User.joins(:visions).where(user_status: false)
      @visions = Vision.where(user_id: users.ids)
      @visions_still = @visions.where(finish_status: false)
      @visions_finish = @visions.where(finish_status: true)
    end
  end

  def show
    @tasks = @vision.tasks.order(completion_on: "ASC")
    @tasks_still = @tasks.where(completion_status: false)
    @tasks_complete =@tasks.where(completion_status: true)
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
    params.require(:vision).permit(:title, :body, :finish_on, :genre_id, :finish_status, :production)
  end

  def ensure_vision
    @vision = Vision.find(params[:id])
  end
end
