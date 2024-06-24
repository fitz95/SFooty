# app/controllers/api/v1/posts_controller.rb
class Api::V1::PostsController < ApplicationController
    before_action :authenticate_request
    before_action :set_user
    before_action :set_post
    load_and_authorize_resource
    before_action :set_post, only: %i[show edit update destroy]
  
    api :GET, '/v1/posts', 'Get all posts'
    def index
      @posts = Post.all
      render json: @posts
    end
  
    api :GET, '/v1/posts/:id', 'Get post by id'
    param :id, :number, desc: 'id of the requested post', required: true
    error code: 404, desc: 'Post not found!'
    def show
      render json: @post
    end
  
    api :POST, '/v1/posts', 'Create a new post'
    def create
      @post = current_user.posts.new(post_params)
  
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    api :PATCH, '/v1/posts/:id', 'Update post by id'
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    api :DELETE, '/v1/posts/:id', 'Delete post by id'
    def destroy
      @post.destroy
      head :no_content
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
        @user = User.find(params[:user_id])
    end
  
    def post_params
      params.require(:post).permit(:title, :body, :photo, :status, :team_id, :player_id, :league_id)
    end
  end
  