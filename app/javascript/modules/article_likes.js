import $ from "jquery"
import axios from "lib/axios"


export function setupLikeButton() {
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

}

