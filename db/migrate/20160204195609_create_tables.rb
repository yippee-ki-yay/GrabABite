class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :row
      t.integer :column
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
