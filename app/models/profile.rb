# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  birth_day    :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  enum :gender, { male: 0, female: 1, non_binary: 2 }

  validates :nickname, length: { maximum: 10 }
  validates :nickname, uniqueness: true
  validate :valid_birth_date_range

  belongs_to :user
  has_one_attached :avatar

  def valid_birth_date_range
    return unless self.birth_day.present?
    if self.birth_day > Date.today
      errors.add(:birth_day, "は未来の日付を指定できません")
    elsif birth_day < 100.years.ago.to_date
      errors.add(:birth_day, "は100歳未満である必要があります")
    end
  end
end
