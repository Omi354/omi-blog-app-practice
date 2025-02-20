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

  belongs_to :user
  has_one_attached :avatar
end
