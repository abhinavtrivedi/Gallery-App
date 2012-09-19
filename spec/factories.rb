FactoryGirl.define do
  factory :user do
    name "Jim Morrison"
    email "jim@roadhouse-blues.com"
    password "morrison"
    password_confirmation "morrison"
  end

  factory :artifact do
    title "New Artifact"
    user
    sample File.open('spec/support/temp.jpg')
    description "This is a new Artifact"
    price 100
    bid_price nil
  end
end