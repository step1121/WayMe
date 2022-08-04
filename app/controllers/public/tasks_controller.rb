class Public::TasksController < ApplicationController
before_action :authenticate_user!
before_action :set_task

def edit
end

def create
  if @task.save
    redirect_to vision_path
  else
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
  @task.delete
  redirect_to vision_path
end 

private

def task_params
  params.require(:task).permit(:content, :completion_on)
end

def set_task
  @vision = Vision.find(params[:vision_id])
end
end
