require "rails_helper"

describe "/api/v1/projects", :type=> :api do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:token) { user.authentication_token }
  let!(:project) {FactoryGirl.create(:project)}
  let!(:project_denied) {FactoryGirl.create(:project, name: "Danied")}
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
       expect( projects.any? do |p|
        p["name"] == project_denied.name
      end ).to be false
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
      puts last_response.body
      expect(last_response.body).to eql(errors)
    end
  end 
end