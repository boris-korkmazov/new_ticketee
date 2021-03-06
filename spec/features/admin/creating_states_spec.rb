require "rails_helper"

feature "Creating states" do
  before do
    visit "/"
    sign_in_as!(FactoryGirl.create(:admin_user))
  end

  scenario "Creating states" do
    click_link "Admin"
    click_link "States"
    click_link "New State"
    fill_in "Name", :with=> "Duplicate"
    click_button "Create State"
    expect(page).to have_content("State has been created.")
  end
end