class ArticlesController < ApplicationController
  def index
    @articles = Article.select(:id, :title, :created_at).order(created_at: :desc)
  end

  def show
    @article = Article.find params[:id]
  end
end
