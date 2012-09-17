class AddAttachmentSampleToArtifacts < ActiveRecord::Migration
  def self.up
    change_table :artifacts do |t|
      t.has_attached_file :sample
    end
  end

  def self.down
    drop_attached_file :artifacts, :sample
  end
end
