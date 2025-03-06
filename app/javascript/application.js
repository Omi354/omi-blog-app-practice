// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
import axios from "lib/axios"

window.$ = jquery

const csrfToken = document.getElementsByName('csrf-token')[0].content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

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

  $('.article_heart-inactive').on('click', () => {
    axios.post(`/articles/${articleId}/likes`)
      .then(response => {
        if (response.data.status) {
          $('.article_heart-active').removeClass('hidden')
          $('.article_heart-inactive').addClass('hidden')
        }
      })
      .catch(error => {
        console.log(error)
        alert(error.response.data.message)
      })

  })

  $('.article_heart-active').on('click', () => {
    axios.delete(`/articles/${articleId}/likes`)
      .then(response => {
        if (response.data.status) {
          $('.article_heart-active').addClass('hidden')
          $('.article_heart-inactive').removeClass('hidden')
        }
      })
      .catch(error => {
        console.log(error)
        alert(error.response.data.message)
      })
  })
})
