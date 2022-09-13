class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  
  def show
    # User情報を取得
    @user = User.find(params[:id])
    # user_roomsテーブルの自分のUserのレコードのroom_idを配列で取得
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    
    # user_roomでルームを取得できなかった（チャットがまだ存在しない）場合の処理  
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      # @user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのカラムに保存
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      # current_user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのカラムに保存
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    # roomに紐づくchatsテーブルのレコードを@chatsに格納
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(current_user)
    end
  end
end
