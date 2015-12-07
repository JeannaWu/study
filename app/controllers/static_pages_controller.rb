class StaticPagesController < ApplicationController
<<<<<<< HEAD
   def home
         if logged_in?
            @micropost  = current_user.microposts.build
            @feed_items = current_user.feed
         end
      end

=======
  def home

  	
         
      end
>>>>>>> log-in-log-out

  def help
  end

  def about    
    # NEW
  end
end
