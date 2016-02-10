class CreateUserVisits < ActiveRecord::Migration
  def change
    create_table :user_visits do |t|
      t.integer :score
      t.references :visit, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
