require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @article = Article.create(
      name: 'name',
      title: 'title',
      url: 'url',
      body: 'body',
      prefecture_id: '13'
    )
  end

  describe 'POST #create' do
    let(:create_params) do{
      comment: {
        name: 'name',
        comment: 'comment',
        article_id: @article.id
      }
    }
    end

    it 'create comment by 1' do
      expect {post :create, params: create_params}.to change(Comment, :count).by(1)
    end

    it 'redirect to article page' do
      post :create, params: create_params
      expect(response).to redirect_to(article_path(@article))
    end
  end

  describe 'DELETE #destory' do
    before do
      @comment = Comment.create(
        name: 'name',
        comment: 'comment',
        article_id: @article.id
      )
    end

    it 'delete the comment' do
      expect do
        delete :destroy, params: {id: @comment.id}
      end.to change(Comment, :count).by(-1)
    end

    it 'redirect to article page' do
      delete :destroy, params: {id: @comment.id}
      expect(response).to redirect_to(article_path(@article))
    end
  end
end
