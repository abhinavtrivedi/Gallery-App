class AddPriceToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :price, :integer
  end
end
