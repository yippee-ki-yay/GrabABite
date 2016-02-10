class CreateTablesConfigurationJoinTable < ActiveRecord::Migration
  def change
    create_join_table :restaurants, :tables do |t|
      # t.index [:restaurant_id, :table_id]
      # t.index [:table_id, :restaurant_id]
    end
  end
end
