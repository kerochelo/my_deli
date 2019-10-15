class FavoriteArticleRelationsController < ApplicationController
  before_action :set_target_article

  def create
    unless current_user.is_fav?(@article)
      current_user.fav(@article)
      redirect_to @article, flash: {
        success: "お気に入り登録しました"
      }
    end
  end

  def destroy
    if current_user.is_fav?(@article)
      current_user.unfav(@article)
      redirect_to @article, flash: {
        danger: "お気に入り解除しました"
      }
    end
  end

  private

  def set_target_article
    @article = Article.find(params[:favorite_article_relation][:article_id])
  end

end
