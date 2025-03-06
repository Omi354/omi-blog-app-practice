class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def show
    has_like =  current_user.favorites.exists?(@article.id)
    render json: { hasLike: has_like }
  end

  def create
    like = current_user.likes.build(article_id: @article.id)
    if like.save
      render json: { status: 'ok' }
    else
      render json: { status: 'ng', message: 'いいねに失敗しました' }, status: :unprocessable_entity
    end
  end

  def destroy
    like = current_user.likes.find_by(article_id: @article.id)
    
    if like.nil?
      render json: { status: 'ng', message: 'いいねが見つかりません' }, status: :not_found
    elsif like.destroy
      render json: { status: 'ok' }
    else
      render json: { status: 'ng', message: 'いいね削除に失敗しました' }, status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
