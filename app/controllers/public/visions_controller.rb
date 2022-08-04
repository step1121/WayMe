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
      @visions = Vision.page(params[:page])
    end
    
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
      params.require(:vision).permit(:title, :body, :finish_on)
    end
    
    def ensure_vision
      @vision = Vision.find(params[:id])
    end
    
end
