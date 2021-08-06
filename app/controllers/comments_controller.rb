class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to article_path(comment.article)
    @article = comment.article
    @article.create_notification_comment!(current_user, comment.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
