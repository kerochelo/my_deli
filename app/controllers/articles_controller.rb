class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order(updated_at: "DESC")
  end

  def new
    @article = Article.new
  end

  def create
    Article.create(article_params)
  end

  def show
    @article = Article.find(params[:id])
  end
  private

  def article_params
    params.require(:article).permit(:name, :title, :url, :body)
  end
end