class User < ActiveRecord::Base

  attr_accessible :email, :name, :password, :password_confirmation
  has_many :artifacts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bid_artifacts, class_name: "Artifact"
  has_many :followed_users, through: :followings, source: :followed
  has_many :followings, foreign_key: "followed_id", dependent: :destroy
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token




  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end


end
