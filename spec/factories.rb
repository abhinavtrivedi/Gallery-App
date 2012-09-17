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
  end
end