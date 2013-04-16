class AddItemsConfirmed < ActiveRecord::Migration
  def self.up
    add_column :order_items,:confirmed,:boolean,:default=>false
    add_column :order_items,:handler,:string
    add_column :order_items,:telephone,:string
  end

  def self.down
    remove_column :order_items,:confirmed
    remove_column :order_items,:handler
    remove_column :order_items,:telephone
  end
end
