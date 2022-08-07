class Public::VisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_item, only: [:show, :edit, :update, :destroy]
  
  def new
    @vision = Vision.new
  end
  
  def create
    @vision.user_id = current_user.id
    @vision.save ? (redirect_to vision_path(@vision)) : (render :new)
  end
  
  def index
    @all_visions = Vision.where(genre_id: params[:genre_id])
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @visions = @all_visions.all
    else
      @visions = Vision.all
    end
  end
  
   # @genres = Genre.only_active
    # @all_visions = Vision.where(genre_id: params[:genre_id])
    # if params[:genre_id]?
    #   @visions = @all_visions.all
    #   redirect_to viisons_path(params[:genre_id])
    # else
    #   @visions = Visions.all
    #   redirect_to visions_path
    # end
  
  def show
    @tasks = @vision.tasks
    @task = Task.new
  end
  
  def edit
  end

  def update
    @vision.update(vision_params) ? (redirect_to vision_path(@vision)) : (render :edit)
  end
  
  def destroy
    @vision.delete
    redirect_to user_path
  end


  private
  
  def vision_params
    params.require(:vision).permit(:title, :body, :finish_on, :genre_id, :finish_status)
  end
  
  def ensure_vision
    @vision = Vision.find(params[:id])
  end
end
