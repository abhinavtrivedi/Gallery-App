class Following < ActiveRecord::Base
  attr_accessible :followed_id

  belongs_to :follower, class_name: "User"
end
