require 'rails_helper'

RSpec.describe User, type: :request do
  before do
  @user = FactoryBot.create(:user)
  end
  
  describe "ユーザー詳細ページを表示(GET #show)" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get user_path(@user)
        expect(response).to redirect_to login_path
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        login_rspec @user
        get user_path(@user)
        expect(response).to have_http_status "200"
      end
    end
  end
  
  describe "ユーザー編集ページを表示(GET #edit)" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get edit_user_path(@user)
        expect(response).to redirect_to login_path
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        login_rspec @user
        get edit_user_path(@user)
        expect(response).to have_http_status "200"
      end
    end
  end  
end