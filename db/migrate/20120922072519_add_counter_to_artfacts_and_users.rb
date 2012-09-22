class AddCounterToArtfactsAndUsers < ActiveRecord::Migration
  def change
    add_column :artifacts, :comment_count, :integer
    add_column :users, :artifact_count, :integer
  end
end
