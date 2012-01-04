class AddVolumeQuantity < ActiveRecord::Migration
  def self.up
    # first - change quantity on line items to float
    change_table :line_items do |t|
      t.change :quantity, :float
    end

    # then add floats: step and round and string: unit
    # to products
    add_column :products, :step,  :float, :default => 1, :null => false
    add_column :products, :round, :float, :default => 1, :null => false
    add_column :products, :unit,  :string
  end

  def self.down
    change_table :line_items do |t|
      t.change :quantity, :integer
    end

    remove_column :products, :step
    remove_column :products, :round
    remove_column :products, :unit
  end
end