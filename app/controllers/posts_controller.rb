class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :correct_user,   only: :destroy
	def index
		@posts = Post.all.order("created_at DESC")
	
		
	end

	def new 
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
		  flash[:success] = "Post created!"
          redirect_to @post
          else
          	@feed_items = []
            render 'new'
        end
	end



	def show
		
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
        redirect_to root_path
	end



	private 

	def find_post
		@post = Post.find(params[:id])
	end
	def post_params
		params.require(:post).permit(:title, :content)
	end

	def correct_user
              @post = current_user.posts.find_by(id: params[:id])
              redirect_to root_url if @post.nil?
      end

end


