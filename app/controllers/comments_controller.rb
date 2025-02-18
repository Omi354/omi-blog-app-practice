class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = current_user.comments.build(article_id: params[:article_id])
  end

  def create
    @comment = current_user.comments.build(comment_params.merge(article_id: params[:article_id]))
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to article_path(@comment.article)
    else
      flash.now[:error] = "コメントに失敗しました"
      render :new, status: :unprocessable_entity
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
