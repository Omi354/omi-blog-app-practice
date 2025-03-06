import { setupLikeButton } from "modules/article_likes"

document.addEventListener('turbo:load', function() {
  setupLikeButton()
})
