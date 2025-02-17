class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end
end
