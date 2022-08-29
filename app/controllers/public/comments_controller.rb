class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comments

  def create
    vision = Vision.find(params[:vision_id])
    @comment = current_user.comments.new(comment_params)
    @comment.vision_id = vision.id
    if @comment.save
      render :index
    else
      render :validater
    end
  end

  def index
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :vision_id)
    end

    def set_comments
      @vision = Vision.find(params[:vision_id])
      @comments = @vision.comments.order(created_at: :desc)
    end

end
