class Admin::VisionsController < ApplicationController
  before_action :authenticate_admin!
 
  def index
    @visions = Vision.page(params[:page])
  end

  def show
    @vision = Vision.find(params[:id])
    @tasks = @vision.tasks
  end

  def destroy
    @vision = Vision.find(params[:id])
    @vision.delete
    redirect_to admin_visions_path
  end


  private

  def vision_params
    params.require(:vision).permit(:title, :genre_id, :body, :finish_on)
  end
end
