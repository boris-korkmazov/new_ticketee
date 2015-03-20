FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com"}
  factory :user do
    name "example"
    email { generate :email }
    password "1234567"
    password_confirmation "1234567"

    factory :admin_user do
      admin true
    end
  end
end