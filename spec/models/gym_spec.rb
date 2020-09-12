require 'rails_helper'

RSpec.describe Gym, type: :model do
  
  describe 'バリデーションのテスト' do
    subject { gym.valid? }
    let(:gym) { create(:gym) }
    
    context '全てのカラムが正常な場合' do
      it 'tureを返す' do
        expect(gym).to be_valid
      end
    end
    context 'nameカラム' do
      it '空欄でないこと' do
        gym.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        gym.name = ''
        gym.valid?
        expect(gym.errors[:name]).to include("を入力してください")
      end
    end
    
    context 'addressカラム'do
      it '空欄でないこと' do
        gym.address = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        gym.address = ''
        gym.valid?
        expect(gym.errors[:address]).to include("を入力してください")
      end
    end
  end    
    
  
  describe 'アソシエーションのテスト' do
    let(:association) do
      # context＞it内に下記を記述するのと同じ
      # expect(User.reflect_on_association(:restaurants).macro).to eq :has_many
      # expect(User.reflect_on_association(:followings).class_name).to eq 'User'
      described_class.reflect_on_association(target)
    end
    
    context 'Postモデルとの関係' do
      let(:target) { :posts }

      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end
    
    context 'Userモデルとの関係' do
      let(:target) { :users }
      
      it '1:Nとなっている（中間テーブルgym_usersを介すので多対多）' do
        expect(association.macro).to eq :has_many
      end
    end
    
    context '中間テーブルGymUserモデルとの関係' do
      let(:target) { :gym_users }

      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
