class CreateFriend < ActiveRecord::Migration
  def change
      create_table :friends , :force => true, :id => false do |t|
          t.integer "user_a", :null => false
          t.integer "user_b", :null => false
    end
  end
end
