require 'spec_helper'

feature "User cannot join meetup again" do


  scenario "Users gets an error message if they try to join meetup again" do
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

    visit '/'
    click_link "Peanut Butter"
    click_button "submit"

    expect(page).to have_content "You have already joined this meetup"
  end
end
