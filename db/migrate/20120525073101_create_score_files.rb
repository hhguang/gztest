class CreateScoreFiles < ActiveRecord::Migration
  def self.up
    create_table :score_files do |t|
      t.string :filename
      t.string :disk_filename
      t.integer :filesize
      t.string :content_type
      t.integer :digest
      t.integer :user_id
      t.integer :school_id
      t.integer :exam_id
      t.boolean :confirmed,     :default=>false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :score_files
  end
end
