class CreateQxes < ActiveRecord::Migration
  def self.up
    create_table :qxes do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :qxes
  end
end
