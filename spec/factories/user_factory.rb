FactoryGirl.define do
  factory :user do
    name "example"
    email "example@mail.ru"
    password "1234567"
    password_confirmation "1234567"
  end
end