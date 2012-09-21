class AddUserIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :string
    add_index :comments, :user_id
  end
end
