class CreatePaperOrders < ActiveRecord::Migration
  def self.up
    create_table :paper_orders do |t|
      t.string :name
      t.integer :item_type
      t.boolean :current

      t.timestamps
    end
  end

  def self.down
    drop_table :paper_orders
  end
end
