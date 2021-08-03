class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @articles = current_user.articles
    @user = User.find(params[:id])
  end
end
