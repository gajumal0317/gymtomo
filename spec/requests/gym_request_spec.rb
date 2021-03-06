require 'rails_helper'

RSpec.describe Gym, type: :request do
  let(:user) { FactoryBot.create(:user) }
  
  describe "#show" do
    
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        gym = FactoryBot.create(:gym)
        get gym_path(gym)
        expect(response).to redirect_to login_path
      end
    end
    
    context "ログインしている場合" do
      it "正常にレスポンスを返すこと" do
        login_rspec user
        gym = FactoryBot.create(:gym)
        get gym_path(gym)
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        login_rspec user
        gym = FactoryBot.create(:gym)
        get gym_path(gym)
        expect(response).to have_http_status "200"
      end
    end
  end
  
  describe "#create" do
    context "ログインユーザーの場合" do
      before do
        login_rspec(user)
      end
      context '有効な属性値の場合' do
        it "ジムを作成できる" do
          gym_params = FactoryBot.attributes_for(:gym)
            expect do
              post "/gyms", params: { gym: gym_params }
            end.to change(Gym.all, :count).by(1)
            expect(response).to redirect_to user_path(user)
            expect(response).to have_http_status "302"
        end
      end
      
      context '無効な属性値の場合' do
        it 'ジムを作成できないこと' do
          gym_params = FactoryBot.attributes_for(:gym, :invalid)
          expect { post '/gyms', params: { gym: gym_params } }.to_not change(Gym, :count)
        end
      end
    end
    
    context 'ログインしないで' do
      it '302レスポンスを返すこと' do
        gym_params = FactoryBot.attributes_for(:gym)
        post '/gyms', params: { gym: gym_params }
        expect(response).to have_http_status '302'
      end

      it 'ログインにリダイレクトすること' do
        gym_params = FactoryBot.attributes_for(:gym)
        post '/gyms', params: { gym: gym_params }
        expect(response).to redirect_to login_path
      end
    end
  end
#以降edit, :update, :destroyはadmin_user
end  
