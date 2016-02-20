class ManagersController < ApplicationController
  layout 'home'
  
  def index
    @managers = User.with_role("restaurant_manager")
    
    
    
  end
end
