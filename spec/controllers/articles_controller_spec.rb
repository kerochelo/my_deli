require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe 'GET #new' do
    before { get :new }

    it 'response code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'rendering new template' do
      expect(response).to render_template :new
    end

    it 'pass new object' do
      expect(assigns(:article)).to be_a_new Article
    end
  end

  describe 'GET #show' do
    before do
      @article = Article.create(
        name: 'name',
        title: 'title',
        url: 'url',
        body: 'body',
        prefecture_id: '13'
      )
    end

    it 'response code 200' do
      get :show, params: {id: @article.id}
      expect(response).to have_http_status(:ok)
    end

  end

  describe 'POST #create' do
    context 'right article info' do
      let(:create_params) do
        {
          article: {
            name: 'name',
            title: 'title',
            url: 'url',
            body: 'body',
            prefecture_id: '13'
          }
        }
      end

      it 'create article by 1' do
        expect {post :create, params: create_params}.to change(Article, :count).by(1)
      end

      it 'redirect to articles page' do
        post :create, params: create_params
        article = Article.last
        expect(response).to redirect_to(article_path(article))
      end
    end

  end

  describe 'PATCH #update' do
    before do
      @article = Article.create(
        name: 'name',
        title: 'title',
        url: 'url',
        body: 'body',
        prefecture_id: '13'
      )
    end

    context 'right article info' do
      let(:updated_params) do
        {
          name: 'name',
          title: 'update',
          url: 'url',
          body: 'body',
          prefecture_id: '13'
        }
      end

      before do
        patch :update, params: {id: @article.id, article: updated_params}
        @article.reload
      end

      it 'update database' do
        expect(@article.title).to eq updated_params[:title]
      end

      it 'redirect to articles page' do
        expect(response).to redirect_to article_path(@article.id)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @article = Article.create(
        name: 'name',
        title: 'title',
        url: 'url',
        body: 'body',
        prefecture_id: '13'
      )
    end

    it 'delete the article' do
      expect do
        delete :destroy, params: {id: @article.id}
      end.to change(Article, :count).by(-1)
    end

    it 'redirect to articles page' do
      delete :destroy, params: {id: @article.id}
      expect(response).to redirect_to(articles_path)
    end
  end

end
