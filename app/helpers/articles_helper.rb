module ArticlesHelper
  def formatted_created_at(article)
    l article.created_at, format: :short
  end
end
