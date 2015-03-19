FactoryGirl.define do
  factory :user do
    name "example"
    email "sample@example.com"
    password "1234567"
    password_confirmation "1234567"
  end
end