class HomeController < ApplicationController
    #ovde mozemo da prikazemo korisnikove informacije
    def index
        
    end
    
    #prikazemo podatke za editovanje profila
    def profile
        
    end
    
    #lista retsorane gde kliknes na njih da rezervises
    def restaurants
        @restaurants = Restaurant.all
    end
    
    #upravljas i dodajes frendove
    def friends
        
    end
    
end
