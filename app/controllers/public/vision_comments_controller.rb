class Public::VisionCommentsController < ApplicationController
before_action :authenticate_user!
  before_action :set_comments

  def create
    vision = Vision.find(params[:vision_id])
    @vision_comment = current_user.vision_comments.new(vision_comment_params)
    @vision_comment.vision_id = vision.id
    if @vision_comment.save
      render :index
    else
      render :validater
    end
  end

  def index
    @vision_comment = VisionComment.new
  end

  def destroy
    @vision_comment = VisionComment.find(params[:id])
    @vision_comment.destroy
    render :index
  end

  private
    def vision_comment_params
      params.require(:vision_comment).permit(:comment, :user_id, :vision_id)
    end

    def set_comments
      @vision = Vision.find(params[:vision_id])
      @vision_comments = @vision.vision_comments.order(created_at: :desc)
    end
end
