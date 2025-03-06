require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article) }

  describe "POST /articles/:article_id/likes" do
    context "ログインしている場合" do
      before do
       post user_session_path, params: { user: { email: user.email, password: 'password' } }
      end

      it "いいねされる" do
        expect {
          post article_likes_path(article_id: article.id)
        }.to change(Like, :count).by(1)
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq 'ok'

        like = Like.last
        expect(like.user).to eq(user)
        expect(like.article).to eq(article)
      end

      context "すでに記事にいいねしている場合" do
        let!(:like) { create(:like, user: user, article: article) }

        it "2回目のいいねはできない" do
          expect {
            post article_likes_path(article_id: article.id)
          }.not_to change(Like, :count)
          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)['status']).to eq 'ng'
          expect(JSON.parse(response.body)['message']).to eq 'いいねに失敗しました'
        end
      end
    end

    context "ログインしていない場合" do
      it "サインイン画面にリダイレクトされる" do
        post article_likes_path(article_id: article.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE /articles/:article_id/likes" do
    context "ログインしている場合" do
      before do
        post user_session_path, params: { user: { email: user.email, password: 'password' } }
      end

      context "いいねが存在する場合" do
        let!(:like) { create(:like, user: user, article: article) }

        it "いいねが削除される" do
          expect {
            delete article_likes_path(article_id: article.id)
          }.to change(Like, :count).by(-1)
          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body)['status']).to eq 'ok'
        end
      end

      context "いいねが存在しない場合" do
        it "エラーが返される" do
          expect {
            delete article_likes_path(article_id: article.id)
          }.not_to change(Like, :count)
          expect(response).to have_http_status(404)
          expect(JSON.parse(response.body)['status']).to eq 'ng'
          expect(JSON.parse(response.body)['message']).to eq 'いいねが見つかりません'
        end
      end
    end

    context "ログインしていない場合" do
      it "サインイン画面にリダイレクトされる" do
        delete article_likes_path(article_id: article.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
