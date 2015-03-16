require 'rails_helper'

feature 'Creating Projects'  do
  before do
    visit '/'
    click_link 'New Project'
  end

  scenario 'can create a project' do 
    

    fill_in 'Name', with: 'TextMate 2'
    fill_in 'Description', with: 'A text editor'
    click_button 'Create Project'

    expect(page).to have_content 'Project has been created.'

    project = Project.where(name: 'TextMate 2').first

    expect(page.current_url).to eql(project_url(project))

    title =  project.name + " - Projects - Ticketee"

    expect(page).to have_title(title)
  end 

  scenario "can  not create a project without a name" do
    click_button "Create Project"
    expect(page).to have_content("Project has not been created.")
    expect(page).to have_content("Name can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "Non-standars complience"
    fill_in "Description", with: "it sucks"
    click_button "Create Ticket"
    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
end