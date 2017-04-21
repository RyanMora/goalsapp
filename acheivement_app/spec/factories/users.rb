# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    username { Faker::Name.name}
    password "password"

    factory :user2 do
      username "username1"
    end

    factory :user3 do
      username "username1"
    end
  end
end
