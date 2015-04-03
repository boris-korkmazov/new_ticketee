require "rails_helper"

describe "rate limiting", :type => :api do
  let(:user) { FactoryGirl.create(:user) }

  it "counts the user's request" do
    expect(user.request_count).to eql 0

    get "/api/v1/projects.json", token: user.authentication_token

    user.reload

    expect(user.request_count).to eql 1
  end

  it "stops a user if they have exceeded the limit" do
    user.update_attribute(:request_count, 101)

    post '/api/v1/projects.json', token: user.authentication_token, project: {name: "sdfsdf"}

    error = { error: "Rate limit exceeded." }

    expect(last_response.status).to eql 403

    expect(last_response.body).to eql(error.to_json)
  end
end