require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "GET #show" do
    user = FactoryGirl.create(:user)
    it "returns http success" do
      get :show, params: {id: 1}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
    it "should return page with status 200" do
      begin
        get :show, params: {id: -1}
      rescue
        ActiveRecord.RecordNotFound
      end
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      post :create, params: {:user => {username: "something", password: "password"}}
      expect(response).to redirect_to(user_url(User.find_by(username: "something")))
    end
    it "should redirect to new page and flash errors" do
      post :create, params: {user: {username: "username", password: "passw"}}
      expect(response).to redirect_to(new_user_url)
      expect(flash[:errors]).to be_present
    end
  end

  describe "GET #destroy" do
    user = FactoryGirl.create(:user)
    it "redirect to new user page if destroy successful" do
      delete :destroy, params: {id: user.id}
      expect(response).to redirect_to(new_user_url)
    end
  end

end
