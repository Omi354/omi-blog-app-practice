class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :content, uniqueness: true

  belongs_to :user
  has_one_attached :eye_catch
end
