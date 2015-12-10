require 'spec_helper'

feature "User sees all members of meetup" do


  scenario "Users sees all members of a meetup" do
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

    expect(page).to have_content "#{user.username}"
  end
end
