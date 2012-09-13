FactoryGirl.define do
  factory :user do
    name "Jim Morrison"
    email "jim@roadhouse-blues.com"
    password "morrison"
    password_confirmation "morrison"
  end
end