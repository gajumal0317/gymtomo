require 'rails_helper'

RSpec.describe Post, type: :model do
  
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let(:gym) { create(:gym) }
    let(:post) { create(:post, user_id: user.id, gym_id: gym.id) }
    
    context 'contentカラムとimgカラムが正常な場合' do
      it 'tureを返す' do
        expect(post).to be_valid
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        post.content = ''
        is_expected.to eq false
      end
      
      it '空欄の場合エラーが出る' do
        post.content = ''
        post.valid?
        expect(post.errors[:content]).to include("を入力してください")
      end
      
      it 'contentが260文字' do
        post.content = 'a'*260
        post.valid?
        expect(post.errors[:content]).to include("は250文字以内で入力してください")
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Userモデルとの関係' do
      let(:target) { :user }

      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
    end
    
    context 'Gymモデルとの関係' do
      let(:target) { :gym }

      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end