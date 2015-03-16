require "rails_helper"

feature "Creating Tikets" do
  before do
    project = FactoryGirl.create(:project, name: "Internet Explorer")

    visit '/'
    click_link project.name
    click_link "New Ticket"
  end

  scenario "Creating a ticket" do
    fill_in "Title", with: "Non standards complience"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
  end

  scenario "Creating a ticket with invalid attributes" do
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Ticket can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end