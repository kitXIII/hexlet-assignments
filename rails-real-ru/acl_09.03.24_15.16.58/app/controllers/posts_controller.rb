# frozen_string_literal: true

class PostsController < ApplicationController
  after_action :verify_authorized, except: %i[index show]

  # BEGIN
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = authorize Post.new
  end

  def create
    @post = authorize Post.create(post_params)
    @post.author = current_user

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = authorize Post.find(params[:id])
  end

  def update
    @post = authorize Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = authorize Post.find(params[:id])

    notification =
      if post && !post.destroy!
        { alert: post.errors.full_messages.to_sentence }
      else
        {}
      end

    redirect_to post, notification
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
  # END
end
