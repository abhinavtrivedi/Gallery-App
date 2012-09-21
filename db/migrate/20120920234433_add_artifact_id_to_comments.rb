class AddArtifactIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :artifact_id, :string
    add_index :comments, :artifact_id
  end
end
