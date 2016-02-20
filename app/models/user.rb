class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
    has_many :restaurant
    
    has_many :user_visits
    
    has_and_belongs_to_many(:friends,
        :class_name => "User",
        :join_table => "friends",
        :foreign_key => "user_a",
        :association_foreign_key => "user_b")
end
