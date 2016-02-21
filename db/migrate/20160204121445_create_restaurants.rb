class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :desc
      t.string :address
      t.string :user_id
        
      t.timestamps null: false
    end
      
  end
end
