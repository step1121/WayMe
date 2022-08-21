class Admin::VisionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @visions = Vision.all
  end

  def show
    @vision = Vision.find(params[:id])
    @tasks = @vision.tasks.order(completion_on: "ASC")
  end

  def destroy
    @vision = Vision.find(params[:id])
    @vision.delete
    redirect_to admin_visions_path
  end


  private

  def vision_params
    params.require(:vision).permit(:title, :body, :finish_on, :genre_id, :finish_status, :production)
  end
end
