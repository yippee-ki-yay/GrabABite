class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
       t.belongs_to :user, index: true
      t.belongs_to :visit, index: true
      
        t.string :added_by
      t.boolean :accepted
       t.integer :score
      t.timestamps null: false
    end
    end

end
