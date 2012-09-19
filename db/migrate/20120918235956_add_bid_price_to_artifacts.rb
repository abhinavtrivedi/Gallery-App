class AddBidPriceToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :bid_price, :integer
  end
end
