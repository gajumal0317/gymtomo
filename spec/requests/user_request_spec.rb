require 'rails_helper'

RSpec.describe User, type: :request do
  let(:user) { FactoryBot.create(:user) }
  # ログインしていないユーザー
  let(:other_user) { FactoryBot.create(:user) }
  
  
  describe "ユーザー詳細ページを表示(GET #show)" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        login_rspec user
        get user_path(user)
        expect(response).to have_http_status "200"
      end
    end
  end

  describe 'Post #create' do
    context '有効なパラメータの場合' do
      let(:user_params) {FactoryBot.attributes_for(:user)}
      
      it 'リクエストは302 リダイレクトとなること' do
        post '/users', params: { user: user_params }
        expect(response.status).to eq 302
      end
      it 'データベースに新しいユーザーが登録されること' do
        expect { post '/users', params: { user: user_params } }.to change { User.count }.by(1)
      end

    end
    context '無効なパラメータの場合' do
      let(:user_params) {FactoryBot.attributes_for(:user, :invalid)}
      
      it 'リクエストが成功することと' do
        post '/users', params: { user: user_params }
        expect(response.status).to eq 200
      end
      it 'データベースに新しいユーザーが登録されないこと' do
        expect { post '/users', params: { user: user_params } }.to_not change { User.count }
      end

    end
  end

  describe "ユーザー編集ページを表示(GET #edit)" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        login_rspec user
        get edit_user_path(user)
        expect(response).to have_http_status "200"
      end
    end
  end  

  describe "ユーザーの編集を更新(PUT #update)" do
    #attributes_forハッシュでパラメーターを渡す
    let(:user_params) {FactoryBot.attributes_for(:user, name: "編集後ユーザー名")}
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        put user_path(user), params: { id: user.id, user: user_params }
        expect(response).to redirect_to login_path
      end
    end

    context "ログインしている場合" do
      before do
        login_rspec user
      end

      it "リクエストが成功すること" do
        put user_path(user), params: { id: user.id, user: user_params }
        expect(response.status).to eq 302
      end
      it "更新が成功すること" do
        put user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq "編集後ユーザー名"
      end
      it "ユーザー詳細ページへリダイレクトすること" do
        put user_path(user), params: { id: user.id, user: user_params }
        expect(response).to redirect_to user_path(user)
      end
    end
  end
# ========================================================
  describe "ログインページ(GET /sign_in)が" do
    it '正しく表示されること' do
      get login_path
      expect(response).to have_http_status(200)
    end
  end
  
  #以下sessionのネストが問題エラー
#  describe "ログイン(POST /sign_in)に" do
    # 存在する(DBに登録されている)ユーザー
 #   let (:authenticated_user) { create(:user) }
    # 存在しない(DBに登録されていない)ユーザー
  #  let (:unauthenticated_user) { build(:user) }
   # let (:req_params) { { user: { session: { email: user.email, password: user.password } } } }
    
    #context '存在するユーザでログインすると' do
     # let (:user) { authenticated_user }

      #it '成功すること' do
       # post login_path, params: req_params
        #expect(response).to have_http_status(302)
      #end
      #it 'ログイン後トップページにリダイレクトされること' do
       # post login_path, params: req_params
        #expect(response).to redirect_to user_path(user)
      #end
    #end
  #end
end