import { setupLikeButton } from "modules/article_likes"

// 即時実行関数で初期化（ページロード直後に実行）
(function() {
  debugger
  const article = document.querySelector(".article");
  if (article) {
    setupLikeButton(article);
  }
})();

// 既存のイベントリスナー
document.addEventListener('turbo:load', function() {
  setupLikeButton(document.querySelector(".article"))
})

