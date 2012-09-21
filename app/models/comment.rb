class Comment < ActiveRecord::Base
  attr_accessible :comment_text, :artifact_id
  belongs_to :user
  belongs_to :artifact

  validates :comment_text, presence: true

end
