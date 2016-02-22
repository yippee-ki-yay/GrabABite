class ReservationController < ApplicationController
    layout 'home'
    before_action :authenticate_user!
    
    def index
        restaurant_id = params[:id]
        
        @curr_restaurant = Restaurant.find(restaurant_id)
        
        #for now this is just getting all the tables
      @available_tables = Table.pluck(:capacity, :id)
    end
  
    
  def visit_done
    visit_id = params[:visit_id]
    
    @visit = Visit.find(visit_id)
    
  end
  
  def rate_visit
    inv = params[:inv]
    rating = params[:rating]
    
    my_inv = Invitation.find(inv)
    my_inv.score = rating
    my_inv.save
    
    render json: true
    
  end
  
  def is_reserved
  end
  
  def invite_friend
    visit_id = params[:visit_id]
    user_email = params[:email]
    
    visit = Visit.find(visit_id)
    
    v = Invitation.new
    v.visit = visit
    v.user = User.find_by_email(user_email)
    
    full_name = current_user.firstname + ' ' + current_user.lastname
    
    v.accepted = false
    v.added_by = full_name
    v.save
    
    visit.invitations.push v
    
    render json: true
    
  end
  
    #we save to database restaurant visit/reservation
    def create
        date = params[:date]
        duration = params[:duration]
        table = params[:table]
        restaurant = params[:restaurant]
        
      
        @visit = Visit.new({start_date: date, duration: duration, table_id:table, restaurant_id:restaurant})
      byebug
      @visit.end_date = @visit.start_date + duration.to_i.hours
        @visit.save
      
       u = Invitation.new
       u.visit = @visit
       u.user = current_user
      u.accepted = true
       u.save
        
      render json: @visit.id
    end
    
    def friends_to_visit
      @visit = Visit.find(params[:id])
      @friends = current_user.friends
    end
    
end
