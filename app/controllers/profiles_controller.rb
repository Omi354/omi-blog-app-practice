class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [ :edit, :update ]

  def show
    @profile = current_user.profile
    @articles = current_user.articles.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "プロフィールを作成しました"
      redirect_to profile_path
    else
      flash.now[:error] = "プロフィール作成に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_profile
    @profile =  current_user.profile || current_user.build_profile
  end

  def profile_params
    params.require(:profile).permit(:nickname, :introduction, :birth_day, :gender, :subscribed, :avatar)
  end
end
