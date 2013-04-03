class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.integer :paper_order_id
      t.integer :school_id
      t.string :school_name
      t.integer :g1yw
      t.integer :g1sx
      t.integer :g1yy
      t.integer :g1wl
      t.integer :g1hx
      t.integer :g1sw
      t.integer :g1zz
      t.integer :g1ls
      t.integer :g1dl
      t.integer :g2w
      t.integer :g2l
      t.integer :g2yw
      t.integer :g2sxl
      t.integer :g2sxw
      t.integer :g2yy
      t.integer :g2wl
      t.integer :g2hx
      t.integer :g2sw
      t.integer :g2zz
      t.integer :g2ls
      t.integer :g2dl
      t.integer :g3w
      t.integer :g3l
      t.integer :g3yw
      t.integer :g3sxl
      t.integer :g3sxw
      t.integer :g3yy
      t.integer :g3wz
      t.integer :g3lz

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
