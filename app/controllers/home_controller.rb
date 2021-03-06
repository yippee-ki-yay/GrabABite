class HomeController < ApplicationController
    layout 'home'
    before_action :authenticate_user!
    #ovde mozemo da prikazemo korisnikove informacije
    def index
      if current_user.has_role? "system_manager"
        redirect_to restaurants_path
      elsif current_user.has_role? "restaurant_manager"
         redirect_to managers_restaurant_restaurants_path
      else
           @visits =  Visit.joins(:invitations).where("invitations.user_id = ? AND 
            invitations.accepted = true", current_user.id )
        @past = @visits.where("end_date < ?", Time.now)
      end
    end
    
    #prikazemo podatke za editovanje profila
    def profile
      redirect_to edit_user_registration_path
    end
    
    #lista retsorane gde kliknes na njih da rezervises
    def restaurants_reserve
        @restaurants = Restaurant.all
    end
    
  
    def visits
      @visits =  Visit.joins(:invitations).where("invitations.user_id = ? AND 
invitations.accepted = true", current_user.id )
      
      @past = @visits.where("end_date < ?", Time.now)
      
      @upcoming = @visits.where("end_date > ?", Time.now)
      
    end
  
    def invitations
      @invitations =  Visit.joins(:invitations).where("invitations.user_id = ? AND 
invitations.accepted = false AND start_date > ?", current_user.id, DateTime.now )
    
    end
    
    #upravljas i dodajes frendove
    def friends
        @all_users = User.all
        
        @my_friends = current_user.friends
        @future_friends = @all_users - current_user.friends
        @future_friends.delete(current_user)
      @future_friends = ((@future_friends - User.with_role("system_manager")) - User.with_role("restaurant_manager"))
    end
    
    def add_friend
        email = params[:email]
        
        unless email.nil?
            friend =  User.find_by_email(email)
            me = User.find(current_user.id)
            me.friends << friend
            friend.friends << me
            render json: true
        else
            render json: false
        end
        
    end
    
    def dump_friend
        email = params[:email]
        
        friend =  User.find_by_email(email)
        
        current_user.friends.delete(friend)
        
        render json: true
    end
  
    #get invite id and set it to accepted
  def accept_invite
    invite_id = params[:invite]
    
    inv = Invitation.find(invite_id)
    inv.accepted = true
    inv.save
    
    render json: true   
  end
  
  #delete the invite record
  def decline_invite
    invite_id = params[:invite]
    
    i = Invitation.find(invite_id)
    i.delete
    
    render json: true
  end
    
end
