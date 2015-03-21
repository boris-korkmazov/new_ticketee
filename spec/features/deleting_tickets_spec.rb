require 'rails_helper'

feature "Deleting tickets" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) {FactoryGirl.create(:user)}
  let!(:ticket) {
    ticket = FactoryGirl.create(:ticket, project: project)
    ticket.update(user: user)
    ticket
  }
  before do
    sign_in_as!(user)
    define_permission!(user, "view", project)
    define_permission!(user, "delete tickets", project)
    visit '/'
    click_link project.name
    click_link ticket.title 
  end

  scenario "Deleting a ticket" do
    
    click_link "Delete Ticket"

    expect(page).to have_content("Ticket has been deleted.")
    expect(page.current_url).to eq(project_url(project))
  end
end