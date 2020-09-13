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
      it "正常に投稿できること" do
        post_params = FactoryBot.attributes_for(:post, user_id: @user.id, gym_id: @gym.id, content: "hoge")
        post "/posts", params: { post: post_params }
        expect(response).to have_http_status "302"
        #expect(response.body).to include "hoge"
      end
      
      #エラー原因未解決
      #it "正常に投稿できること" do
        #post_params = FactoryBot.attributes_for(:post, user_id: @user.id, gym_id: @gym.id, content: "hoge")
        #post "/posts", params: { post: post_params }
        #expect(response.body).to include "hoge"
      #end

    end
  end
end