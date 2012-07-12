class AddUserQxid < ActiveRecord::Migration
  def self.up
    add_column :users,:qx_id,:integer
  end

  def self.down
    remove_column :users,:qx_id
  end
end
