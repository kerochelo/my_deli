class ArticlesController < ApplicationController
  before_action :set_target_article, only: %i[show edit update destroy]

  def index
    # うまく直したい
    @articles = params[:tag_id].present? ? Tag.find(params[:tag_id]).articles : Article.all
    @articles = @articles.where(prefecture_id: params[:prefecture_id]) if params[:prefecture_id].present?
    @articles = word_search(@articles, params[:free_word]) if params[:free_word].present?
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

  # strong_params
  def article_params
    params.require(:article).permit(:name, :title, :url, :body, :prefecture_id, tag_ids: [])
  end

  #before_action
  def set_target_article
    @article = Article.find(params[:id])
  end

  # 複数検索用
  def word_search(base_model ,word_params)
    free_word = word_params
    if free_word.present?
      words = free_word.to_s.split(" ")
      columns = ["title", "body"]
      query = []
      result = []

      columns.each do |col|
        query << ["#{col} LIKE ?"]
      end

      words.each_with_index do |word, index|
        if index == 0
          result[index] = base_model.where([query.join(" OR "), "%#{word}%", "%#{word}%"])
        else
          result[index] = result[index-1].where([query.join(" OR "), "%#{word}%", "%#{word}%"])
        end
      end
      return result[words.length-1]
    else
      base_model
    end
  end

end