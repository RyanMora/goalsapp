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

require 'rails_helper'


RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

    context "ensure_session_token" do
      it 'should generate new session_token after creating a new User' do
        user = FactoryGirl.build(:user)
        expect(user.session_token).not_to eq(nil)
      end
    end
    context "not valid params" do
      it "should raise error if password not length 6" do
        user = FactoryGirl.build(:user, password:  "pass")
        expect(user).not_to be_valid
      end
      it "should raise error if username not unique" do
        # subject(:user) {User.create(username: 'username1', password: 'password')}
        # subject(:user2) {User.create(username: 'username1', password: 'password')}
        user = FactoryGirl.create(:user2)
        user2 = FactoryGirl.build(:user3)
        user2.valid?
        expect(user2.errors.full_messages).to include("Username has already been taken")
      end
    end
  end

  describe 'associations' do
    it {should have_many(:goals) }
    it {should have_many(:comments) }
  end

  describe "class methods" do
    user = FactoryGirl.create(:user)
    context "::find_by_credentials(username,password)" do
      it "should find user based on username and password" do
        user2 = FactoryGirl.create(:user2)
        expect(User.find_by_credentials("username1", "password")).to eq(user2)
      end
    end
    context "#password=(password)" do
      it "set our password instance variable" do
        expect(user.password).to eq("password")
      end
      it "should generate and set a password_digest" do
        expect(user.password_digest).not_to eq(nil)
      end
    end
    context "#is_password?(password)" do
      it "should return true if right password" do
        expect(user.is_password?("password")).to be true
      end
      it "should return false if wrong password" do
        expect(user.is_password?("passwor")).to be false
      end
    end
    context "#reset_session_token" do
      session_token = user.session_token
      user.reset_session_token
      it "should reset the session_token" do
        expect(user.session_token).not_to eq(session_token)
      end
      it "should save the sesssion_token" do
        expect(User.find(user.id).session_token).to eq(user.session_token)
      end
    end

    context "::generate_session_token" do
      it "should generate a session_token" do
        expect(User.generate_session_token).not_to eq(nil)
      end
    end
  end


end
