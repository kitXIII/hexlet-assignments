class ArticlesController < ApplicationController
  def index
    @articles = Article.select(:id, :title, :created_at).order(created_at: :desc)
  end

  def show
    @article = Article.find_by(id: params[:id])
  end
end
