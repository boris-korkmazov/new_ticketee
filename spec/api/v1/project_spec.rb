require "rails_helper"

describe "/api/v1/projects", :type=> :api do
  let!(:user) { FactoryGirl.create(:user, admin:true) }
  let!(:token) { user.authentication_token }
  let!(:project) {FactoryGirl.create(:project)}
  before do
    define_permission!(user, "view", project)

  end


  context "projects viewable by this user" do
    let(:url) {"/api/v1/projects"}

    it "json" do
      get "#{url}.json", :token => token

      projects_json = Project.for(user).all.to_json

      expect(last_response.body).to eql(projects_json)

      expect(last_response.status).to eql(200)

      projects = JSON.parse(last_response.body)

      expect( projects.any? do |p|
        p["name"] == project.name
      end ).to be true
    end

    it "XML" do
      get "#{url}.xml", token: token

      expect(last_response.body).to eql(Project.for(user).to_xml)

      projects = Nokogiri::XML(last_response.body)
      expect(projects.css("project name").text).to eql(project.name)

    end
  end

  context "creating a project" do

    let(:url) { "/api/v1/projects" }

    it "successful JSON" do

      post "#{url}.json", token: token, project: { name: "Inspector" }

      project = Project.find_by_name!("Inspector")

      route = "/api/v1/projects/#{project.id}"

      expect(last_response.status).to eql 201

      expect(last_response.headers["Location"]).to eql(route)

      expect(last_response.body).to eql(project.to_json)
    end


    it "unsuccessful JSON" do
      post "#{url}.json", token: token, project: {name: ""}

      expect(last_response.status).to eql(422)

      errors = {
        "errors"=> {
          "name" => ["can't be blank"]
        }
        }.to_json
      expect(last_response.body).to eql(errors)
    end
  end

  context "show" do
    let(:url) {"/api/v1/projects/#{project.id}"}

    before do
      FactoryGirl.create(:ticket, project: project)
    end

    it "JSON" do
      get "#{url}.json", token: token

      project_json = project.to_json(:methods =>"last_ticket")

      expect(last_response.body).to eql(project_json)

      expect(last_response.status).to eql(200)

      project_response = JSON.parse(last_response.body)

      ticket_title = project_response["last_ticket"]['title']

      expect(ticket_title).to_not be_blank
    end
  end


  context "updating a project" do
    let(:url) { "/api/v1/projects/#{project.id}" }

    it "successful JSON" do
      put "#{url}.json", token: token, project: { name: "Not Ticketee" }


      expect(last_response.status).to eql 204
      expect(last_response.body).to eql("")

      project.reload

      expect(project.name).to eql("Not Ticketee")
    end

    it "unsuccessful JSON" do
      put "#{url}.json", token: token, project: { name: "" }

      expect(last_response.status).to eql 422

      errors = { errors: {name: ["can't be blank"] } }

      expect(last_response.body).to eql errors.to_json
    end
  end

  context "deleting a project" do
    let(:url) { "/api/v1/projects/#{project.id}" }

    it "JSON" do
      delete "#{url}.json", token: token

      expect(last_response.status).to eq 204
    end
  end
end