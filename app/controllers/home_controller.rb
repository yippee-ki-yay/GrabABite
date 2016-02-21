class HomeController < ApplicationController
    layout 'home'
    before_action :authenticate_user!
    #ovde mozemo da prikazemo korisnikove informacije
    def index
        
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
invitations.accepted = false", current_user.id )
    end
  
    def invitations
      @invitations =  Visit.joins(:invitations).where("invitations.user_id = ? AND 
invitations.accepted = false", current_user.id )

    end
    
    #upravljas i dodajes frendove
    def friends
        @all_users = User.all
        
        @my_friends = current_user.friends
        @future_friends = @all_users - current_user.friends
        @future_friends.delete(current_user)
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
    
end
