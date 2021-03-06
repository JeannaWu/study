class UsersController < ApplicationController
   before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def show
        @user = User.find(params[:id])
         
        @posts = @user.posts.paginate(page: params[:page])
      end

      def index
        @users = User.paginate(page: params[:page])

      end

      def new
      	@user = User.new
      end

      def create
         secure_params = params.require(:user).permit(:name, :email, 
                                  :password, :password_confirmation)
         @user = User.new(secure_params)
           if @user.save
              remember @user
              flash[:success] = "Welcome to the Forum App!"
              redirect_to @user
            else
             render 'new' 
             end
       end

       def following
          @title = "Following"
          @user  = User.find(params[:id])
          @users = @user.following.paginate(page: params[:page])
         render 'show_follow'
        end

      def followers
          @title = "Followers"
          @user  = User.find(params[:id])
          @users = @user.followers.paginate(page: params[:page])
          render 'show_follow'
       end

      def edit
         @user = User.find(params[:id])
      end

      def destroy
         User.find(params[:id]).destroy
         flash[:success] = "User deleted"
         redirect_to users_url
       end

    def update
      @user = User.find(params[:id])
     if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
     else
      render 'edit'
    end
  end

private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

   
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
