require "rails_helper"

feature "Creating comments" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }
  before do
    define_permission!(user, "view", project)
    FactoryGirl.create(:state, name: "Open")
    sign_in_as!(user)
    visit '/'
    click_link project.name
  end

  scenario "Creating a comment" do
    click_link ticket.title

    fill_in "Text", :with=> "Added a comment!"
    click_button "Create Comment"
    expect(page).to have_content("Comment has been created.")
    within("#comments") do
      expect(page).to have_content("Added a comment!")
    end
  end

  scenario "Creating a comment with  invalid fields" do
    click_link ticket.title

    click_button "Create Comment"

    expect(page).to have_content("Comment has not been created.")
    #expect(page).to have_content("Text can't be blank")
  end

  scenario "Changing a ticket's state" do
    define_permission!(user, "change states", project)
    click_link ticket.title
    fill_in "Text", :with=> "This is real issue"
    select "Open", :from => "State"

    click_button "Create Comment"
    expect(page).to have_content("Comment has been created.")
    within "#ticket .state" do
      expect(page).to have_content("Open")
    end
    within "#comments" do
      expect(page).to have_content("State: Open")
    end
  end

  scenario "A user without permission cannot change the state" do
    click_link ticket.title
    find_element = lambda { find("#comment_state_id") }
    message = "Expected not to see #comment_state_id, but did."
    expect(find_element).to raise_error(Capybara::ElementNotFound), message
  end

end