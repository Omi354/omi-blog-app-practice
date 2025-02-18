class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = current_user.comments.build(article_id: params[:article_id])
  end
end
