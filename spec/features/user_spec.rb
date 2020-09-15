require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  # 新しいユーザーを作成する
  scenario 'creates a new user' do
    visit signup_path

    expect do
      fill_in 'Name', with: 'test_user'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirmation', with: 'password'
      click_button 'Sign up'

      expect(page).to have_content 'ユーザを登録しました'
    end.to change { User.count }.by(1)
  end
    # ログインする
  scenario 'creates a new user' do
    visit login_path
    user = FactoryBot.create(:user)

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'ログインしました。'
  end
end