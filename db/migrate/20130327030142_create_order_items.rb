class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.integer :paper_order_id
      t.integer :school_id
      t.string :school_name
      t.integer :g1yw,:default=>0
      t.integer :g1sx,:default=>0
      t.integer :g1yy,:default=>0
      t.integer :g1wl,:default=>0
      t.integer :g1hx,:default=>0
      t.integer :g1sw,:default=>0
      t.integer :g1zz,:default=>0
      t.integer :g1ls,:default=>0
      t.integer :g1dl,:default=>0
      t.integer :g2w,:default=>0
      t.integer :g2l,:default=>0
      t.integer :g2yw,:default=>0
      t.integer :g2sxl,:default=>0
      t.integer :g2sxw,:default=>0
      t.integer :g2yy,:default=>0
      t.integer :g2wl,:default=>0
      t.integer :g2hx,:default=>0
      t.integer :g2sw,:default=>0
      t.integer :g2zz,:default=>0
      t.integer :g2ls,:default=>0
      t.integer :g2dl,:default=>0
      t.integer :g3w,:default=>0
      t.integer :g3l,:default=>0
      t.integer :g3yw,:default=>0
      t.integer :g3sxl,:default=>0
      t.integer :g3sxw,:default=>0
      t.integer :g3yy,:default=>0
      t.integer :g3wz,:default=>0
      t.integer :g3lz,:default=>0

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
