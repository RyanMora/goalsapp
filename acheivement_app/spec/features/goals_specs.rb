require 'spec_helper'
require 'rails_helper'

feature "creating goals" do
  user = FactoryGirl.create(:user)
  scenario "adds a new goal" do
    visit new_sessions_url
    fill_in("Username", with: user.username)
    fill_in("Password", with: "password")
    click_on("submit")
    save_and_open_page
    visit(user_url(user))

    click_on("New Goal")
    fill_in("Title" , with: "lose weight")
    fill_in("Body", with: "run every day and eat better food")
    check("Private")
    click_on("submit")

    expect(page).to redirect_to(goal_url(Goal.find_by(user_id: user.id, title: "lose weight")))
    expect(page).to have_content("run every day and eat better food")
  end

end

feature "editting goals" do

  scenario "shows updated text after edditting goal"

end

feature "deleting goals" do

  user = FactoryGirl.create(:user)
  scenario "goal no longer exists"

end

feature "show private goals to only the current user" do

  user = FactoryGirl.create(:user)
  scenario "logged in user can see private goals"
  scenario "when logged out you can't see private goals"

end
