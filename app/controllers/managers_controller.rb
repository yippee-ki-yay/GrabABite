class ManagersController < ApplicationController
  layout 'home'
  
  def index
    if current_user.has_role? "system_manager"
      @managers = User.with_role("restaurant_manager")
    else
      redirect_to home_index_path
    end
  end
  
  def new
    if current_user.has_role? "system_manager"
      @manager = User.new
      @restaurants = Restaurant.all
    else
      redirect_to home_index_path
    end
  end
  
   def create

     @manager = User.new(manager_params)
     @manager.add_role "restaurant_manager"
     @manager.restaurant_id = manager_params[:restaurant_id]
     @manager.skip_confirmation!
    
    respond_to do |format|
      if @manager.save
        format.html { redirect_to managers_path, notice: 'Manager was successfully created.' }
        format.json { render :show, status: :created, location: @manager }
      else
        format.html { render :new }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  private
  
   # Never trust parameters from the scary internet, only allow the white list through.
  def manager_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :restaurant_id)
    end
  
end
