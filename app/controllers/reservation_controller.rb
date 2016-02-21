class ReservationController < ApplicationController
    layout 'home'
    before_action :authenticate_user!
    
    def index
        restaurant_id = params[:id]
        
        @curr_restaurant = Restaurant.find(restaurant_id)
        
        #for now this is just getting all the tables
      @available_tables = Table.pluck(:capacity, :id)
    end
    
    #we save to database restaurant visit/reservation
    def create
        date = params[:date]
        duration = params[:duration]
        table = params[:table]
        restaurant = params[:restaurant]
        
         byebug
        
        @visit = Visit.new({start_date: date, duration: duration, table_id:table, restaurant_id:restaurant})
        @visit.save
        
        redirect_to friends_to_visit_reservation_index_path
    end
    
    def friends_to_visit
    end
    
end
