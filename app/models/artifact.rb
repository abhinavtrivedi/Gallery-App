class Artifact < ActiveRecord::Base
  attr_accessible :title, :sample, :description, :price
  belongs_to :user
  has_attached_file :sample, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :title, presence: true
  validates :user_id, presence: true
  validates :price, presence: true
  validates_attachment :sample, presence: true,
      :content_type => { :content_type => "image/jpeg" },
      :size => { :in => 0..2.megabytes }

end
