// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
import "axios"
window.$ = jquery


// Turbo Driveのロードイベントで実行される関数
document.addEventListener('turbo:load', function() {
  console.log('Page loaded with Turbo Drive');
  $('.article_title').click(() => {
    alert("clicked")
  })

  // axiosを使ったGETリクエストのサンプル
  console.log('Sending test axios GET request...');
  axios.get('/articles')
    .then(response => {
      console.log('Axios request successful');
      console.log('Data received:', response.data);
      
      // データを使って何か処理をする例
      const articleCount = response.data.length || 0;
      console.log(`Found ${articleCount} articles`);
      
      // 取得したデータをUIに表示する例
      $('#axios-response-container').html(`<p>Loaded ${articleCount} articles via axios</p>`);
    })
    .catch(error => {
      console.error('Axios request failed:', error);
      $('#axios-response-container').html('<p class="text-danger">Failed to load data</p>');
    })
    .finally(() => {
      console.log('Axios request completed');
    });
  
  // ここに初期化コードやページ読み込み時に実行したいコードを記述します
  // 例：
  // $('.some-element').on('click', function() {
  //   console.log('Element clicked!');
  // });
  
  // Ajaxリクエストの例
  // axios.get('/api/data')
  //   .then(response => {
  //     console.log('Data loaded:', response.data);
  //   })
  //   .catch(error => {
  //     console.error('Error loading data:', error);
  //   });
});

