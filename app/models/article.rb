# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :content, uniqueness: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :eye_catch
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def formats_created_at
    I18n.l
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
