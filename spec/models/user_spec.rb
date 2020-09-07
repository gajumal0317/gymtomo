require 'rails_helper'

RSpec.describe User, type: :model do
    
  it "is valid with name, email and password" do
    user = User.new(
      name: "test",
      email: "test@sample.com",
      password: "test"
      )
    expect(user).to be_valid
  end
  
  # 名前がなければ無効。
  it "is invalid without name" do
    user = User.new(
        name: nil,
        email: "test@sample.com",
        password: "test")
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

end
