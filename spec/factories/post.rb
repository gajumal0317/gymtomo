FactoryBot.define do
  factory :post do
    content { Faker::Lorem.characters(number: 20) }
    img {Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.jpg'))}
    association :user
    association :gym
  # factory名が違う場合以下のように記述する
  # association :user, factory: :tom
  
     # 無効になっている
    trait :invalid do
      content { nil }
    end
  end
end