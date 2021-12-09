class RoomsController < ApplicationController
    
    before_action :authenticate_user!
    
  def create
    @room = Room.create
    @user_room = User_room.create(room_id: @room.id, user_id: current_user.id)
    @user_room = User_room.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end
  
  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @chats = @room.chats
      @chat = Message.new
      @user_rooms = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
