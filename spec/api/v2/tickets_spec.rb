require "rails_helper"

describe "/api/v1/tickets", :type=> :api do
  let!(:project) { FactoryGirl.create(:project, :name=> "Ticketee") }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    define_permission!(user, "view", project)
  end

  let(:token) { user.authentication_token }

  context "index" do
    before do
      5.times do
        FactoryGirl.create(:ticket, :project=> project, :user => user)
      end
    end

    let(:url) {"/api/v1/projects/#{project.id}/tickets"}

    it "XML" do
      get "#{url}.xml", token: token

      expect(last_response.body).to eql project.tickets.to_xml
    end


    it "JSON" do
      get "#{url}.json", token: token

      expect(last_response.body).to eql project.tickets.to_json
    end
  end 

  context "pagination" do
    before do
      3.times do 
        FactoryGirl.create(:ticket, :project=> project, user: user)
      end

      @default_per_page = Kaminari.config.default_per_page

      Kaminari.config.default_per_page = 1
    
    end

    after do
      Kaminari.config.default_per_page = @default_per_page
    end

    it "gets the first page" do
      get "/api/v2/projects/#{project.id}/tickets.json", token: token, page: 1

      expect(last_response.body).to eql(project.tickets.page(1).to_json)
    end

    it "gets the second page" do
      get "/api/v2/projects/#{project.id}/tickets.json", token: token, page: 2
      
      expect(last_response.body).to eql(project.tickets.page(2).to_json)
    end
  end
end
