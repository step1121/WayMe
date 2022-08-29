class Public::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vision
  before_action :set_task, except: [:create, :index]
  before_action :baria_user, except: [:create, :index]

  def edit
  end

  def create
    vision = Vision.find(params[:vision_id])
    @task = Task.new(task_params)
    @task.vision_id = vision.id
    if @task.save
      redirect_to vision_path(@vision)
    else
      @tasks = @vision.tasks.order(completion_on: "ASC")
      # 未完了TASK
      @tasks_yet = @tasks.yet
      # 完了TASK
      @tasks_complete =@tasks.complete
      render 'public/visions/show'
    end
  end
   
  def index
    redirect_to Vision.find(params[:vision_id])
  end

  def update
    @task.update(task_params) ? (redirect_to vision_path(@vision)) : (render :edit)
  end


  def complete
    @tasks = @vision.tasks.all
    # TASKステータスの切り替え
    @task.completion_status == false ? (@task.update(completion_status: true)) : (@task.update(completion_status: false))
    # 全TASK完了ステータスとVISION達成ステータスの連動
    @tasks.where(completion_status: true).count != @tasks.count ? (@vision.update(finish_status: false)) : (@vision.update(finish_status: true))
    redirect_to request.referer
  end

  def destroy
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

  def set_task
    @task = Task.find(params[:id])
  end

  def baria_user
    unless Task.find(params[:id]).vision.user.id == current_user.id
        redirect_to vision_path(@vision)
    end
  end
end
