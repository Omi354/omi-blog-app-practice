// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
import "axios"
window.$ = jquery

document.addEventListener('turbo:load', function() {
  const articleId = $('.article').data('article-id')
  
  axios.get(`/articles/${articleId}/likes`)
    .then(response => {
      if (response.data.hasLike) {
        $('.article_heart-active').removeClass('hidden')
      } else {
        $('.article_heart-inactive').removeClass('hidden')
      }
    })
    .catch(error => {
      console.log(error)
    })


})

