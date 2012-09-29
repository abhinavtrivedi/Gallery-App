class User < ActiveRecord::Base

  attr_accessible :email, :name, :password, :password_confirmation
  has_many :artifacts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bid_artifacts, class_name: "Artifact"

  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :followings, source: :followed

  has_many :reverse_followings, foreign_key: "followed_id", class_name: "Following", dependent: :destroy
  has_many :followers, through: :reverse_followings, source: :follower

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  def following?(other_user)
    followings.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    followings.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    followings.find_by_followed_id(other_user.id).destroy
  end


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end


end
