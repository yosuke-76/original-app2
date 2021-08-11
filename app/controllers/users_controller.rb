class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :set_follow, only: [:followings, :followers]
  def show
    @user = User.find(params[:id])
    @articles = current_user.articles
    @relationship = current_user.relationships.find_by(follow_id: @user.id)  
    @set_relationship = current_user.relationships.new
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def followings
    @users = @user.followings.all
  end

  def followers
    @users = @user.followers.all
  end
  
  private
  def set_follow
    @user = User.find(params[:id])
  end
end
