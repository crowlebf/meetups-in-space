require 'spec_helper'

feature "User cannot see meetups if not signed in" do


  scenario "Users gets an error message if they try to view a meetup while they are not signed in" do
    user = FactoryGirl.create(:user)
    visit '/'
    sign_in_as user

    visit "meetups/new"

    fill_in "name", with: "Peanut Butter"
    fill_in "location", with: "Boston"
    fill_in "description", with: "Stuff"

    click_button "submit"
    visit '/'
    click_link "Sign Out"

    click_link "Peanut Butter"

    expect(page).to have_content "You're not signed in"
  end
end
