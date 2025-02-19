class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [ :destroy ]
  before_action :authorize_destroy, only: [ :destroy ]

  def new
    @comment = current_user.comments.build(article_id: params[:article_id])
  end

  def create
    # TODO: 長いのでメソッドとして切りだす
    @comment = current_user.comments.build(comment_params.merge(article_id: params[:article_id]))
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to article_path(@comment.article)
    else
      flash.now[:error] = "コメントに失敗しました"
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    @comment.destroy!
    flash[:notice] = "コメントを削除しました"
    redirect_to article_path(@comment.article), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_destroy
    unless current_user == @comment.user || current_user == @comment.article.user
      flash[:error] = "削除権限がありません"
      redirect_to article_path(@comment.article)
    end
  end

end
