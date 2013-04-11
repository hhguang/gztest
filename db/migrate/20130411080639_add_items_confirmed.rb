class AddItemsConfirmed < ActiveRecord::Migration
  def self.up
    add_column :order_items,:confirmed,:boolean,:default=>false
  end

  def self.down
    remove_column :order_items,:confirmed
  end
end
