require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article) }

  describe "POST /articles/:article_id/likes" do
    context "ログインしている場合" do
      before do
       post user_session_path, params: { user: { email: user.email, password: 'password' } }
      end

      it "いいねされ、リダイレクトされる" do
        expect {
          post article_likes_path(article_id: article.id)
        }.to change(Like, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(article_path(article))

        like = Like.last
        expect(like.user).to eq(user)
        expect(like.article).to eq(article)
      end

      it "同じ記事に2回目のいいねはできない" do
        post article_likes_path(article_id: article.id)

        # 2回目のいいねは件数が増えないことを確認
        expect {
          post article_likes_path(article_id: article.id)
        }.not_to change(Like, :count)
      end
    end

    context "ログインしていない場合" do
      it "サインイン画面にリダイレクトされる" do
        post article_likes_path(article_id: article.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
