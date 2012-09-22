class AddArtifactIdToComments < ActiveRecord::Migration
  def up
    add_column :comments, :artifact_id, :integer
    add_index :comments, :artifact_id
  end

  def down
    remove_column :comments, :artifact_id
    remove_index :comments, :artifact_id
  end

end
