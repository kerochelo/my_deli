class ArticlesController < ApplicationController
  before_action :set_target_article, only: %i[show edit update destroy]

  def index
    @articles = Article.page(params[:page]).order( created_at: "DESC",updated_at: "DESC")
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
    @article.update(article_params)

    redirect_to article
  end

  def destroy
    @article.delete

    redirect_to articles_path, flash: {notice: "[#{@article.title}]を削除しました"}
  end

  private

  def article_params
    params.require(:article).permit(:name, :title, :url, :body)
  end

  def set_target_article
    @article = Article.find(params[:id])
  end
end