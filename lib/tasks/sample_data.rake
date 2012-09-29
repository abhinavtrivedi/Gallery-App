namespace :db do
  desc "Fill db with sample data"
  task populate: :environment do
    create_users
    create_followings
  end
end

def create_users
  50.times do |n|
    name = Faker::Name.name
    email = "email#{n}@galleryapp.com"
    password = "password"
    User.create!(name: name, email: email, password: password, password_confirmation: password)
  end
end

def create_followings
  users = Users.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow! followed }
  followers.each { |follower| follower.follow! user }
end