class AddAvgToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :score, :int
    add_column :restaurants, :num_rates, :int
  end
end
