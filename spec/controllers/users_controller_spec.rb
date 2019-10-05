require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before { get :new }

    it 'response code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'rendering new template' do
      expect(response).to render_template :new
    end

    it 'pass new object' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    before do
      @referer = 'http://localhost'
      @request.env['HTTP_REFERER'] = @referer
    end

    context 'right user info' do
      let(:params) do
        { user: {
          name: 'user',
          password: 'password',
          password_confirmation: 'password'
          }
        }
      end

      it 'create user by 1' do
        expect {post :create, params: params}.to change(User, :count).by(1)
      end

      it 'redirect to mypage' do
        expect(post :create, params: params).to redirect_to mypage_path
      end
    end

    context 'wrong user info' do
      before do
        post(:create, params: {
          user: {
            name: 'UserOne',
            password: 'password',
            password_confirmation: 'password_confirmation'
          }
        })
      end

      it 'redirect to referer' do
        expect(response).to redirect_to @referer
      end

      it 'include error message' do
        expect(flash[:error_messages]).to include 'パスワード(確認)とパスワードの入力が一致しません', 'ユーザ名は小文字英数字で入力してください'
      end
    end
  end
end
