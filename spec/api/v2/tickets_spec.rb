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

end
