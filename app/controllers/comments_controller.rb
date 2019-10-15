class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to comment.article, flash: {
        success: "コメントを投稿しました"
      }
    else
      flash[:comment] = comment
      flash[:error_messages] = comment.errors.full_messages
      redirect_back(fallback_location: comment.article)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.article, flash: {danger: "コメント削除しました"}
  end

  private
  
  def comment_params
    params.require(:comment).permit(:article_id, :name, :comment)
  end
end
