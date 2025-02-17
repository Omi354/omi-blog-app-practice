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

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = "投稿が完了しました"
      redirect_to article_path(@article)
    else
      flash.now[:error] = "投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :eye_catch)
  end
end
