require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content "New User"
  end

end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit(new_user_url)
      fill_in("Username", with: "Bryant")
      fill_in("Password", with: "password")
      click_on("submit")
      expect(page).to have_content "Welcome Bryant"
  end

end

feature "logging in" do

  user = FactoryGirl.create(:user)
  scenario "shows username on the homepage after login" do
    visit new_sessions_url
    fill_in("Username", with: user.username)
    fill_in("Password", with: "password")
    click_on("submit")
    expect(page).to have_content "Welcome #{user.username}"
  end

end

feature "logging out" do

  user = FactoryGirl.create(:user)
  scenario "begins with a logged out state" do
    visit users_url
    click_button("Logout")
    expect(page).to have_content "Log In"
  end
  scenario "doesn't show username on the homepage after logout" do
    visit new_sessions_url
    fill_in("Username", with: user.username)
    fill_in("Password", with: "password")
    click_on("submit")
    visit users_url
    click_button('Logout')
    expect(page).to have_content "Log In"
  end

end
