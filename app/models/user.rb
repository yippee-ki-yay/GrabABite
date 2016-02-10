class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
    belongs_to :restaurant
    
    has_many :user_visits
    
    has_and_belongs_to_many(:users,
        :join_table => "friends",
        :foreign_key => "user_a",
        :association_foreign_key => "user_b")
end
