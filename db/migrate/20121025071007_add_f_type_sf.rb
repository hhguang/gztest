class AddFTypeSf < ActiveRecord::Migration
  def self.up
    add_column :score_files,:f_type,:integer
  end

  def self.down
    remvoe_column :score_files,:f_type
  end
end
