class ReservationController < ApplicationController
    def index
        @restaurant_id = params[:id]
    end
    
end
