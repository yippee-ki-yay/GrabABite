class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
    layout 'home'
  # GET /restaurants
  # GET /restaurants.json
  def index
    if current_user.has_role? "system_manager"
      @restaurants = Restaurant.all
    else
      redirect_to home_index_path
    end
   
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    if current_user.has_role? "system_manager"

    else
      redirect_to home_index_path
    end
  end


  #shows info about the restaurant
  def managers_restaurant
    if current_user.has_role? "restaurant_manager"
      @managed_restaurant = current_user.restaurant
    else
      redirect_to home_index_path
    end
  end
  
  def menu
    if current_user.has_role? "restaurant_manager"
      @menu = current_user.restaurant.items
    else
      redirect_to home_index_path
    end
  end
  
  def add_item
    name = params[:name]
    desc = params[:desc]
    price = params[:price]
    
    
    item = Item.new({name: name, desc: desc, price: price})
    item.with_lock do
      item.save
      current_user.restaurant.items.push item
    end
    
    render json: true
    
  end
  
  # post adds a new table to the restaurant
  def add_table
    seats = params[:number_seats]
    row = params[:row]
    if current_user.has_role? "restaurant_manager"
        table = Table.new
      
      table.with_lock do
          table.capacity = seats
          table.row = row
          table.save

          curr_restaurant = current_user.restaurant
          curr_restaurant.tables.push table
      end
      
      render json: true
      
    else
      render json: false
    end
    
    
  end
  
  #opens the screen where you can set up the configuration
  def add_tables  
  end
  
  # GET /restaurants/new
  def new
    if current_user.has_role? "system_manager"
      @restaurant = Restaurant.new
      @available_managers = User.with_role("restaurant_manager")
    else
      redirect_to home_index_path
    end
  end
    
  # GET /restaurants/1/edit
  def edit
     if current_user.has_role? "system_manager"
     
     elsif current_user.has_role? "restaurant_manager"
       
     else
      redirect_to home_index_path
    end
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    
    
    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
     @restaurant.update(restaurant_params)
        
        if current_user.has_role? "restaurant_manager"
          redirect_to managers_restaurant_restaurants_path
        else
          redirect_to restaurants_path
        end
      
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    u = User.find_by_restaurant_id(@restaurant.id)
    u.restaurant_id = nil
    u.save
    
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :desc, :user_id)
    end
end
