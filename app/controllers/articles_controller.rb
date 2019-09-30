class ArticlesController < ApplicationController
  before_action :set_target_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
    # うまく直したい
    @articles = Tag.find(params[:tag_id]).articles if params[:tag_id].present?
    @articles = @articles.where(prefecture_id: params[:prefecture_id]) if params[:prefecture_id].present?
    @articles = @articles.page(params[:page]).order(created_at: "DESC", updated_at: "DESC")
  end

  def new
    @article = Article.new
  end

  def create
    article = Article.new(article_params)
    if article.save
      # redirect_to articles_path
      redirect_to article, flash: {
        notice: "[#{article.title}]を投稿しました"
      }
    else
      flash[:article] = article
      flash[:error_messages] = article.errors.full_messages
      redirect_back(fallback_location: new_article_path)
    end
  end

  def show
    @comment = Comment.new(article_id: @article.id)
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, flash: {
        notice: "[#{@article.title}]を更新しました"
      }
    else
      flash[:article] = @article
      flash[:error_messages] = @article.errors.full_messages
      redirect_back(fallback_location: @article)
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path, flash: {notice: "[#{@article.title}]を削除しました"}
  end

  private

  def article_params
    params.require(:article).permit(:name, :title, :url, :body, :prefecture_id, tag_ids: [])
  end

  def set_target_article
    @article = Article.find(params[:id])
  end
end