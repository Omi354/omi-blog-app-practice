class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :content, uniqueness: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :eye_catch

  def formats_created_at
    I18n.l
  end
end
