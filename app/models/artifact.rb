class Artifact < ActiveRecord::Base
  attr_accessible :title, :sample
  belongs_to :user
  has_attached_file :sample, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :title, presence: true
end
