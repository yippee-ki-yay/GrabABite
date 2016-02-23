class Restaurant < ActiveRecord::Base
  has_many :users
    has_many :visits
    
    has_and_belongs_to_many :tables
    has_and_belongs_to_many :items
  
    validates :name, :presence => true
    validates :desc, :presence => true
  validates :address, :presence => true
end
