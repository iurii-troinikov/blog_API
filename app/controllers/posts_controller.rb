class PostsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_post, only: %i[show update destroy]
  def index
    posts = Post.all

    render json: posts, each_serializer: PostSerializer
  end

  def show
    render json: @post, serializer: PostSerializer, status: :ok

  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, serializer: PostSerializer, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: post, each_serializer: PostSerializer, status: :ok
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render json: {}, status: :no_content
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])

  end
end
