require 'spec_helper'

feature "User sees all available meetups" do


  scenario "Users creates new meetup and sees them on index" do
    user = FactoryGirl.create(:user)
    visit '/'
    sign_in_as user

    visit "meetups/new"

    fill_in "name", with: "Peanut Butter"
    fill_in "location", with: "Boston"
    fill_in "description", with: "Stuff"

    click_button "submit"

    expect(page).to have_content "Peanut Butter"
    visit '/'
    click_link "Sign Out"
  end
end
