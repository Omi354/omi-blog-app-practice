import jquery from "jquery"
import axios from "lib/axios"

window.$ = jquery

const fetchLikeStatus = (articleId, heartActive, heartInactive) => {
  axios.get(`/articles/${articleId}/likes`)
    .then(response => {
      if (response.data.hasLike) {
        heartActive.classList.remove("hidden")
      } else {
        heartInactive.classList.remove("hidden")
      }
    })
    .catch(error => {
      console.log(error)
    })
}

const addLike = (articleId) => {
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
}

const removeLike = (articleId) => {
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

export function setupLikeButton(articleElement) {
  if (!articleElement) return

  const articleId = articleElement.dataset.articleId
  const heartActive = articleElement.querySelector(".article_heart-active");
  const heartInactive = articleElement.querySelector(".article_heart-inactive");

  fetchLikeStatus(articleId, heartActive, heartInactive)
  addLike(articleId)
  removeLike(articleId)
}

