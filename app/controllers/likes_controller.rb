class LikesController < ApplicationController
  before_action :set_article

  def create
    like = current_user.likes.build(article_id: @article.id)
    like.save
    redirect_to article_path(@article)
  end

  def destroy
    like = current_user.likes.find_by(article_id: @article.id)
    like.destroy
    redirect_to article_path(@article)
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
