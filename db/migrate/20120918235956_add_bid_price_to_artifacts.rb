class AddBidPriceToArtifacts < ActiveRecord::Migration
  def self.up
    add_column :artifacts, :bid_price, :integer
    add_column :artifacts, :bid_at, :datetime
    add_column :artifacts, :bid_user_id, :integer
  end

  def self.down
    remove_column :artifacts, :bid_price, :integer
    remove_column :artifacts, :bid_at, :datetime
    remove_column :artifacts, :bid_user_id, :integer
  end
end
