FactoryBot.define do
  factory :post do
    association :user
  # factory名が違う場合以下のように記述する
  # association :user, factory: :tom
  end
end