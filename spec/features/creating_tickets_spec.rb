require "rails_helper"

feature "Creating Tikets" do
  let!(:user) { FactoryGirl.create(:user)}
  before do
    project = FactoryGirl.create(:project, name: "Internet Explorer")
    define_permission!(user, "view", project)
    define_permission!(user, "create tickets", project)

    visit '/'

    message = "You need to sign in or sign up before continuing."
    expect(page).to have_content(message)

    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "Sign in"

    click_link project.name
    click_link "New Ticket"
  end

  scenario "Creating a ticket" do
    fill_in "Title", with: "Non standards complience"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"
    within "#ticket #author" do
      expect(page).to have_content("Created by #{user.email}")
    end
    expect(page).to have_content("Ticket has been created.")
  end

  scenario "Creating a ticket with invalid attributes" do
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "Non-standars complience"
    fill_in "Description", with: "it sucks"
    click_button "Create Ticket"
    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
=begin
  scenario "Creating tickets with ad attachment" do
    fill_in "Title", with:"Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File #1", "spec/fixtures/speed.txt"
    attach_file "File #2", "spec/fixtures/spin.txt"
    attach_file "File #3", "spec/fixtures/gradient.txt"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
    
    within "#ticket .assets" do
      expect(page).to have_content("speed.txt")
      expect(page).to have_content("spin.txt")
      expect(page).to have_content("gradient.txt")
    end
  end
=end
  scenario "Creating a ticket with an attachment", js: true, :driver => :chrome do
    fill_in "Title", with: "Add documentation for blink tag"
    fill_in "Description", with: "Blink tag's speed attribute"

    attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")

    click_link "Add another file"

    attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")

    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")

    within("#ticket .assets") do
      expect(page).to have_content("speed.txt")
      expect(page).to have_content("spin.txt")
    end
  end
end