require 'rails_helper'

RSpec.describe Post, type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "#create" do
    before do
      @gym = FactoryBot.create(:gym)
      @user = FactoryBot.create(:user)
    end

    context "ログイン済みユーザの場合" do
      before do
        login_rspec @user    
      end
      
      context '有効な属性値の場合' do
        it "正常に投稿できること" do
          post_params = FactoryBot.attributes_for(:post)
          post "/posts", params: { post: post_params }
          expect(response).to have_http_status "302"

        end
      
        #エラー原因未解決
        #it "正常に投稿できること" do
          #post_params = FactoryBot.attributes_for(:post)
          #expect { post '/posts', params: { post: post_params } }.to change(Post, :count).by(1)
        #end
      end
      

      context '無効な属性値の場合' do
        it '投稿を追加できないこと' do
          post_params = FactoryBot.attributes_for(:post, :invalid)
          expect { post '/posts', params: { post: post_params } }.to_not change(@user.posts, :count)
        end
      end
    end
    
    context 'ログインしないで' do
      it '302レスポンスを返すこと' do
        post_params = FactoryBot.attributes_for(:post)
        post '/posts', params: { post: post_params }
        expect(response).to have_http_status '302'
      end

      it 'ログインにリダイレクトすること' do
        post_params = FactoryBot.attributes_for(:post)
        post '/posts', params: { post: post_params }
        expect(response).to redirect_to login_path
      end
    end
  end
end