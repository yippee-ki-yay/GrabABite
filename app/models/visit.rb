class Visit < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :table
    
    has_many :user_visits
end
