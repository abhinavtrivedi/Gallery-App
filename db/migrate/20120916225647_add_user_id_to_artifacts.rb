class AddUserIdToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :user_id, :string
    add_index :artifacts, :user_id
  end
end
