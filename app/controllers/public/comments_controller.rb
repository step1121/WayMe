class Public::CommentsController < ApplicationController

  def create
    # コメントをする対象の投稿(travel_record)のインスタンスを作成
    vision = Vision.find(params[:vision_id])
    @comment = current_user.comments.new(comment_params)
    @comment.vision_id = vision.id
    @comment.save
    render :index
  end

  def index
    @vision = Vision.find(params[:vision_id])
    # コメント一覧表示で使用する全コメントデータを代入（新着順で表示）
    @comments = @vision.comments.order(created_at: :desc)
    # コメントの作成
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :vision_id)
    end
end
