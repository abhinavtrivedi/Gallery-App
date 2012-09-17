class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.string :title
      t.integer :artist_id

      t.timestamps
    end
  end
end
