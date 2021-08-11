class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:edit, :update, :show]
  def index
    @articles = Article.order('created_at DESC')
    @like = Like.new
  end
  
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
    @like = Like.new
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to root_path
  end

  private
  def article_params
    params.require(:article).permit(:address, :store_name, :text, images: []).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
