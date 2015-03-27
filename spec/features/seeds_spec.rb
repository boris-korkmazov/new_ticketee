require "rails_helper"

feature "Seed data" do
  scenario "The basics" do
    load Rails.root + "db/seeds.rb"
    user = User.where(email: "admin@example.com").first!
    project = Project.where(name: "Ticketee Beta").first!
  end

  scenario "The basic" do
    load Rails.root + "db/seeds.rb"
    user = User.find_by_email("admin@example.com")
    user.password = "password"
    sign_in_as!(user)
    click_link "Ticketee Beta"
    click_link "New Ticket"
    fill_in "Title", with: "Comments with state"
    fill_in "Description", with: "Comments always have a state."
    click_button "Create Ticket"
    within "#comment_state_id" do
      expect(page).to have_content("New")
      expect(page).to have_content("Open")
      expect(page).to have_content("Closed")
    end
  end
end