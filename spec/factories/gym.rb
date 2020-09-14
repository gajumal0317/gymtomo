FactoryBot.define do
  factory :gym do
    name {"test_gym"}
    address {"test_city"}
    img {Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.jpg'))}
  
    trait :invalid do
      name { nil }
    end
  end
end