class Public::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vision, except: [:update]
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def create
    vision = Vision.find(params[:vision_id])
    @task = Task.new(task_params)
    @task.vision_id = vision.id
    if @task.save
      redirect_to vision_path(@vision)
    else
      @task = Task.all
      render vision_path
    end
  end
  
  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to  vision_path(@task.vision)
  end
  
  def complete
    @task = Task.find(params[:id])
    @task.update(completion_status: true)
    redirect_to vision_path(@vision)
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.delete
    redirect_to vision_path(@vision)
  end 
  
  private
  
  def task_params
    params.require(:task).permit(:content, :completion_on, :vision_id, :completion_status)
  end
  
  def set_vision
    @vision = Vision.find(params[:vision_id])
    
  end
end
