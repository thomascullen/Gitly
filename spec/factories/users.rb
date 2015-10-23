FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    auth_token SecureRandom.hex(32)
  end
end
