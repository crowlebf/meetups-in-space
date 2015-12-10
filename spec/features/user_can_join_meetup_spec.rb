require 'spec_helper'

feature "User joins meetup" do


  scenario "Users can join a meetup" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    visit '/'
    sign_in_as user

    visit "meetups/new"

    fill_in "name", with: "Peanut Butter"
    fill_in "location", with: "Boston"
    fill_in "description", with: "Stuff"

    click_button "submit"
    visit '/'
    click_link "Sign Out"

    sign_in_as user2
    click_link "Peanut Butter"
    click_button "submit"

    expect(page).to have_content "#{user2.username}"
  end
end
