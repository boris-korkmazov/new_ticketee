require "rails_helper"

describe "Project API errors", :type=> :api do
  context "standard users" do
    let(:user) { FactoryGirl.create(:user) }

    it "cannot create projects" do
      post "/api/v1/projects.json", token: user.authentication_token, project: { name: "Ticketee"}

      error = { error: "You must be an admin to do that." }
      puts last_response.body
      expect(last_response.body).to eql(error.to_json)
      expect(last_response.status).to eql(401)
      expect(Project.find_by_name("Ticketee")).to be nil
    end
  end
end