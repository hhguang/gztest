class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :name
      t.text :value
      t.integer :qx_id

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
