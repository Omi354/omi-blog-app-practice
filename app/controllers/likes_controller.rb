class LikesController < ApplicationController
  before_action :set_article

  def create
    like = current_user.likes.build(article_id: @article.id)
    like.save!
    flash[:notice] = "いいねしました"
    redirect_to article_path(@article)
  end

  def destroy
    like = current_user.likes.find_by(article_id: @article.id)
    like.destroy!
    flash[:notice] = "いいねを取り消しました"
    redirect_to article_path(@article), status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
