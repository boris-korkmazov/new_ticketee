require "rails_helper"
feature "Viewing tickets" do
  before do 
    textmate_2 = FactoryGirl.create(:project, name: "Text Mate 2")

    FactoryGirl.create(:ticket, 
      project: textmate_2,
      title: "Make it shiny!",
      description: "Gradients!"
      )

    internet_explorer = FactoryGirl.create(:project, name: "Internet Explorer")

    FactoryGirl.create(:ticket, 
      project: internet_explorer,
      title: "Standarts complience.",
      description: "Isn't a joke."
    )
    visit '/'
  end

  scenario "Viewing tickets for a given project" do
    click_link "Text Mate 2"

    expect(page).to have_content("Make it shiny!")
    expect(page).to_not have_content("Standarts complience")

    click_link "Make it shiny!"
    within("#ticket h2") do
      expect(page).to have_content("Make it shiny!")
    end

    expect(page).to have_content("Gradients!")
  end
end