require 'rails_helper'

RSpec.describe GymUser, type: :model do
  describe 'バリデーションのテスト' do
    subject { gym_user.valid? }
    
    let(:user) { create(:user) }
    let(:gym) { create(:gym) }
    let(:gym_user) { create(:gym_user, user_id: user.id, gym_id: gym.id) }
    
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
end