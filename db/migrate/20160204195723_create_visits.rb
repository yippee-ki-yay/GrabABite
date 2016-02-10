class CreateVisits < ActiveRecord::Migration
  def change    
    create_table :visits do |t|
      t.datetime :start_date
      t.time :duration
      t.references :restaurant, index: true, foreign_key: true
      t.references :table, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
