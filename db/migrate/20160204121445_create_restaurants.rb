class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :desc
      t.string :address
        
      t.timestamps null: false
    end
      
        add_reference :restaurants, :user, index: true
      
  end
end
