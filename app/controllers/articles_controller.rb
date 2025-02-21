class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_article, only: [ :show ]
  before_action :set_user_article, only: [ :edit, :update, :destroy ]

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def show
    @comments = @article.comments.all
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

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "更新に成功しました"
      redirect_to article_path(@article)
    else
      flash.now[:error] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy!
    flash[:notice] = "記事を削除しました"
    redirect_to articles_path, status: :see_other
  end

  def liked_articles
    @articles = current_user.liked_articles
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :eye_catch)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def set_user_article
    @article = current_user.articles.find(params[:id])
  end
end
