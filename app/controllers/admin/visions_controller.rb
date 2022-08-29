class Admin::VisionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_vision, only: [:show, :destroy]

  def index
    @visions = Vision.all
  end

  def show
    @tasks = @vision.tasks.order(completion_on: "ASC")
  end

  def destroy
    @vision.delete
    redirect_to admin_visions_path
  end


  private

  def vision_params
    params.require(:vision)
  end

  def ensure_vision
    @vision = Vision.find(params[:id])
  end
end
