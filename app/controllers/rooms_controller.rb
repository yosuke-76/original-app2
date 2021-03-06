class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @rooms = current_user.rooms
    @currentEntries = current_user.entries
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(user_id: current_user.id)
  end

  def create
    @room = Room.create
    @entry1 = Entry.create(user_id: current_user.id, room_id: @room.id )
    @entry2 = Entry.create(join_room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
  private
  def join_room_params
    params.permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end
