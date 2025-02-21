class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.favorites.order(created_at: :asc)
  end
end
