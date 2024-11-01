# app/controllers/api/v1/posts_controller.rb
class Api::V1::PostsController < ApplicationController
  before_action :authenticate_request
  before_action :set_user
  before_action :set_post, only: %i[show edit update destroy]
  load_and_authorize_resource

  api :GET, '/api/v1/users/:user_id/posts', 'Get all posts for a user'
  def index
    @posts = Post.all
    render json: @posts
  end

  api :GET, '/api/v1/users/:user_id/posts/:id', 'Get a post by id for a user'
  param :id, :number, desc: 'ID of the requested post', required: true
  error code: 404, desc: 'Post not found!'
  def show
    render json: @post
  end

  api :POST, '/api/v1/users/:user_id/posts', 'Create a new post for a user'
  def create
    @post = @user.posts.new(post_params)
    
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/api/v1/users/:user_id/posts/:id', 'Update a post by id for a user'
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/api/v1/users/:user_id/posts/:id', 'Delete a post by id for a user'
  def destroy
    @post.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :photo, :status, :team_id, :player_id, :video, :additional_images, :league_id)
  end
end
