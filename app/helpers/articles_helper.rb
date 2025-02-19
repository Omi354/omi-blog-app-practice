module ArticlesHelper
  def formatted_created_at(article)
    l article.created_at, format: :short
  end

  def display_eye_catch(article)
    return unless article.eye_catch.attached?

    content_tag(:div, class: 'article_image') do
      image_tag(article.eye_catch)
    end
  end

  def display_article_actions(article)
    return unless written_by_current_user?(article)

    content_tag(:div, class: 'article_detail_actions') do
      content_tag(:div, class: 'dropdown') do
        image_tag('actions.svg', class: "dropbtn").html_safe +
        content_tag(:div, class: 'dropdown-content mini') do
          link_to('編集する', edit_article_path(article)).html_safe +
          link_to('削除する', article_path(article), data: { turbo_method: :delete, turbo_confirm: '本当に削除しますか？' })
        end
      end
    end
  end
end
