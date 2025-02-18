module UsersHelper
  def written_by_current_user?(article)
    article.user == current_user
  end
end
