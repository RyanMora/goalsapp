# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  title      :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  private    :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :goal do
    
  end
end
