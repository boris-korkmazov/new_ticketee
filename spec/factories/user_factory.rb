FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com"}
  sequence(:name) {|n| "example#{n}"}
  factory :user do
    name { generate :name }
    email { generate :email }
    password "1234567"
    password_confirmation "1234567"

    factory :admin_user do
      admin true
    end
  end
end