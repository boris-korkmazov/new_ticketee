require "rails_helper"

feature "Paginating tickets" do
  let(:project) { FactoryGirl.create(:project) }

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as!(user)
    define_permission!(user, :view, project)
    @default_per_page = Kaminari.config.default_per_page
    Kaminari.config.default_per_page = 1

    3.times do |i|
      FactoryGirl.create(:ticket, project: project, user: user, title: "ticket ##{i}")
    end

    visit root_path

    click_link project.name
  end

  after do 
    Kaminari.config.default_per_page = @default_per_page
  end

  scenario "displays pagination" do
    expect(all(".pagination .page").count).to be 3

    within(".pagination .next") do
      click_link "Next"
    end

    current_page = find("*.pagination .current").text.strip
    expect(current_page).to eql "2"
  end
end