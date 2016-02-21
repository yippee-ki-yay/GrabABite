class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
    layout 'home'
  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
   # @restaurants =User.joins(:restaurant)
   # byebug
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end


  #shows info about the restaurant
  def managers_restaurant
    if current_user.has_role? "restaurant_manager"
      @managed_restaurant = current_user.restaurant
      
    end
  end
  
  # post adds a new table to the restaurant
  def add_table
    seats = params[:number_seats]
    if current_user.has_role? "restaurant_manager"
        table = Table.new
        table.capacity = seats
        table.save
    
      curr_restaurant = current_user.restaurant
      curr_restaurant.tables.push table
      
      render json: true
      
    else
      redner json: false
    end
    
    
  end
  
  #opens the screen where you can set up the configuration
  def add_tables  
  end
  
  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    @available_managers = User.with_role("restaurant_manager")
  end
    
  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    user = User.find(restaurant_params[:user_id])
    
    
    respond_to do |format|
      if @restaurant.save
        user.restaurant_id = @restaurant.id
        user.save
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
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
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
