class Visit < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :table
    
  has_many :invitations
  has_many :users, through: :invitations
end
