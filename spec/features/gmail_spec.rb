require "rails_helper"

feature "Gmail" do
  let!(:alice) { FactoryGirl.create(:user, name: "alice")}

  let!(:me) { FactoryGirl.create(:user, name: "me", :email=>"boriskorkmazov1989@gmail.com") }

  let!(:project) { FactoryGirl.create(:project) }

  let!(:ticket) do
    FactoryGirl.create(:ticket, project: project, user: me)
  end

  before do
    ActionMailer::Base.delivery_method = :smtp
    define_permission!(alice, "view", project)
    define_permission!(me, "view", project)
  end

  scenario "Receiving a real-word email" do
    
    sign_in_as! alice

    visit project_ticket_path(project, ticket)
    fill_in "Text", with: "Posting a comment1"
    click_button "Create Comment"
    expect(page).to have_content("Comment has been created.")
    
    expect(ticketee_emails.count).to eq 1

    email = ticketee_emails.first
    subject = "[ticketee] #{project.name} - #{ticket.title}"

    expect(email.subject).to include(subject)

    clear_ticketee_emails!
  end

  after do
    ActionMailer::Base.delivery_method = :test
  end
end