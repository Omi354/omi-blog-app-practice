module CommentsHelper
  def has_delete_authority?(comment, article)
    current_user == comment.user || current_user == article.user
  end
end
