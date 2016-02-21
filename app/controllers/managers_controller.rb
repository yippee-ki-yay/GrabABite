class ManagersController < ApplicationController
  layout 'home'
  
  def index
    @managers = User.with_role("restaurant_manager")
    
  end
  
  def new
    @manager = User.new
    @restaurants = Restaurant.all
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
  
  def destroy
    @manager.destroy
    respond_to do |format|
      format.html { redirect_to managers_path, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
  
   # Never trust parameters from the scary internet, only allow the white list through.
  def manager_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :restaurant_id)
    end
  
end
