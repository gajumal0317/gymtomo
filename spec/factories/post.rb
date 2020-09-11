FactoryBot.define do
  factory :post do
    #content {何か書く}
    association :user
    association :gym
  # factory名が違う場合以下のように記述する
  # association :user, factory: :tom
  end
end