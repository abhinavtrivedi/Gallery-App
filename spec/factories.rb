FactoryGirl.define do
  sequence(:email) {|n| "person-#{n}@example.com" }

  factory :user do
    name "Jim Morrison"
    email
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

  factory :comment do
    comment_text "This is a new comment"
    artifact
  end
end