require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'アソシエーション' do
    it 'Userに属していること' do
      expect(Like.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'Articleに属していること' do
      expect(Like.reflect_on_association(:article).macro).to eq :belongs_to
    end
  end

  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:article) { create(:article) }
    let!(:like) { create(:like, user: user, article: article) }

    it '同じユーザーが同じ記事に複数のいいねはできないこと' do
      new_like = build(:like, user: user, article: article)
      expect(new_like).not_to be_valid
      expect(new_like.errors[:user_id]).to include('はすでに存在します')
    end

    it '異なるユーザーは同じ記事にいいねできること' do
      another_user = create(:user)
      new_like = build(:like, user: another_user, article: article)
      expect(new_like).to be_valid
    end

    it '同じユーザーは異なる記事にいいねできること' do
      another_article = create(:article)
      new_like = build(:like, user: user, article: another_article)
      expect(new_like).to be_valid
    end
  end

  describe '作成' do
    let(:user) { create(:user) }
    let(:article) { create(:article) }

    it 'いいねを正常に作成できること' do
      like = build(:like, user: user, article: article)
      expect(like).to be_valid
    end
  end
end
