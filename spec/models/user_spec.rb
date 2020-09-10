require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'バリデーションのテスト' do
    # subject〜を書くことでis_expected〜を使えるようになる
    subject { test_user.valid? }
    # 備忘録：letが呼び出された時点で実行される
    # 備忘録：createはDBに保存されるがbuildは保存されない
    
    let(:user) { create(:user)}
    let(:user_2) { create(:user)}

    context 'nameカラム' do
      let(:test_user) { user }
    
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.name = ''
        test_user.valid?
        expect(test_user.errors[:name]).to include("を入力してください")
      end
    end
    
    context 'emailカラム'do
      let(:test_user) { user }
      let(:test_user_2) { user_2 }
      
      it '空欄でないこと' do
        test_user.email = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.email = ''
        test_user.valid?
        expect(test_user.errors[:email]).to include("を入力してください")
      end

      it '一意であること' do
        # 登録できたら失敗
        test_user.email = 'test1@test.co.jp'
        test_user.save
        test_user_2.email = 'test1@test.co.jp'
        test_user_2.save
        test_user_2.valid?
        expect(test_user_2).to be_invalid
        # expect(test_user_2).not_to be_validの上記と同じ意味
      end

      it '一意でない場合はエラーが出る' do
        test_user.email = 'test1@test.co.jp'
        test_user.save
        test_user_2.email = 'test1@test.co.jp'
        test_user_2.save
        test_user_2.valid?
        expect(test_user_2.errors[:email]).to include("はすでに存在します")
      end
    end
    
    context 'passwordカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.password = ''
        is_expected.to eq true
      end
      
      #エラー原因不明
      it '空欄の場合はエラーが出る' do
        test_user.password = ''
        test_user.valid?
        expect(test_user.errors[:password]).to include("を入力してください")
      end
      #エラー原因不明
      it 'パスワードが不一致' do
        test_user.password = "password1"
        test_user.password_confirmation = "password2"
        test_user.save
        test_user.valid?
        expect(test_user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
      
      it 'パスワードが5文字' do
        test_user.password = "12345"
        test_user.password_confirmation = "12345"
        test_user.valid?
        expect(test_user.errors[:password]).to include("は6文字以上で入力してください")
      end
      
    end
  end    
  describe 'データベースへの接続のテスト' do
    subject { described_class.connection_config[:database] }

    it '指定のDBに接続していること' do
      is_expected.to match(/gymtomo_test/)
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
    
    context 'Gymモデルとの関係' do
      let(:target) { :gyms }

      it { expect(association.class_name).to eq 'Gym' }
    end
  end
end
