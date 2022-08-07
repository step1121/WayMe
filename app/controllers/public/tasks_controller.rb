class Public::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def create
    vision = Vision.find(params[:vision_id])
    @task = Task.new(task_params)
    @task.vision_id = vision.id
    if @task.save
      redirect_to vision_path(@vision.id)
    else
      @task = Task.all
      render vision_path
    end
  end
  
  def update
    @task = @vision.tasks.find(params[:id])
    @task.update
    if @vision.are_all_tasks_completed?
        @vision.true!
    end
    redirect_to  vision_path
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.delete
    redirect_to vision_path(@vision)
  end 
  
  private
  
  def task_params
    params.require(:task).permit(:content, :completion_on, :vision_id)
  end
  
  def set_task
    @vision = Vision.find(params[:vision_id])
  end
end
