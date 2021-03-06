require "rails_helper"


feature "Ticket Notifications" do
  let!(:alice) { FactoryGirl.create(:user, name:'alice', :email => "alice@example.com") }
  let!(:bob) { FactoryGirl.create(:user, :name=>"bob", :email=> "bob@example.com") }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) do
    FactoryGirl.create(:ticket, :project=> project, :user=>alice)
  end

  before do
    ActionMailer::Base.deliveries.clear

    define_permission!(alice, "view", project)
    define_permission!(bob, "view", project)

    sign_in_as!(bob)
    visit "/"
  end

  scenario "Ticket owner receives notifications about comments" do
    click_link project.name
    click_link ticket.title
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"

    email = find_email!(alice.email)
    subject = "[ticketee] #{project.name} - #{ticket.title}"
    expect(email.subject).to include(subject)
    click_first_link_in_email(email)

    within "#ticket h2" do
      expect(page).to have_content(ticket.title)
    end
  end

  scenario "Comment authors are automatically subscribed to a ticket" do
    click_link project.name
    click_link ticket.title
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"
    expect(page).to have_content("Comment has been created.")
    find_email!(alice.email)
    click_link "Sign out"

    reset_mailer

    sign_in_as!(alice)

    click_link project.name
    click_link ticket.title

    fill_in "Text", with: "Not yet!"

    click_button "Create Comment"

    expect(page).to have_content("Comment has been created.")

    find_email!(bob.email)

    expect(lambda {find_email!(alice.email)}).to raise_error
  end
end