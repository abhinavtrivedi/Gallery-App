class AddBidAtBidUserIdToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :bid_at, :datetime
    add_column :artifacts, :bid_user_id, :integer
  end
end
