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
    r_id = params[:rest_id]
    
    my_inv = Invitation.find(inv)
    my_inv.score = rating
    my_inv.save
    
    restaurant = Restaurant.find(r_id)
     if restaurant.score == nil
       restaurant.score = 0
     end
    restaurant.score = restaurant.score + my_inv.score
    
    if restaurant.num_rates == nil
      restaurant.num_rates = 0
    end
    
    restaurant.num_rates = restaurant.num_rates + 1
    
    restaurant.save
    
    render json: true
    
  end
  
  
  def get_tables
    
    rest_id = params[:rest_id]
   
    
    if current_user.has_role? "restaurant_manager"
      r = Restaurant.find(current_user.restaurant_id)
    else
       r = Restaurant.find(rest_id)
    end
    
    respond_to do |format|
      format.json { render :json => r.tables }
     end
    
  end
  
  def choose_table
     @visit = Visit.find(params[:id])
  end
  
  #adds a table to visit
  def table_to_visit
    visit = params[:visit]
    table_id = params[:table_id]
    

      v = Visit.find(visit)
    
        @visits = Visit.where("table_id = ?", table_id)
    @visits = @visits.where("(end_date >= ? and end_date <= ?) or (start_date >= ? and start_date <= ?)", 
      v.start_date, v.end_date, v.start_date, v.end_date)
    
    
    if @visits.empty?
      v.with_lock do
        v.table_id = table_id
        v.save
      end

      render json: v.id
    else
      render json: false
    end
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
  
  #gets all the tables that are reserved for a given restaurant and time
  def table_reserved
    rest_id = params[:restaurant_id]
    visit_id = params[:visit_id]
    
    vi = Visit.find(visit_id)
    
    @visits = Visit.where("restaurant_id = ?", rest_id)
    @visits = @visits.where("(end_date >= ? and end_date <= ?) or (start_date >= ? and start_date <= ?)", 
      vi.start_date, vi.end_date, vi.start_date, vi.end_date)
    
    render json: @visits
    
  end
  
    #we save to database restaurant visit/reservation
    def create
        date = params[:date]
        duration = params[:duration]
        restaurant = params[:restaurant]
        min = params[:min]
        hours = params[:hours]
      
       date = date + ' ' + hours + ':' + min

      
      @visit = Visit.new({start_date: date, duration: duration, restaurant_id:restaurant})
      @visit.with_lock do
        @visit.end_date = @visit.start_date + duration.to_i.hours
        @visit.save
      end
      
       u = Invitation.new
      
      u.with_lock do
         u.visit = @visit
         u.user = current_user
         u.accepted = true
         u.save
      end
        
      render json: @visit.id
    end
    
    def friends_to_visit
      @visit = Visit.find(params[:id])
      @f = (current_user.friends - @visit.users).uniq
      u = User.with_role "system_manager" 
      @friends = (@f - u) - (User.with_role "restaurant_manager")
      @added_friends = @visit.users
    end
    
end
