require 'rails_helper'

RSpec.describe User, type: :model do
  describe "email" do
    it "requires an email" do
      u = User.new(name: "steve",
        password: "hunter",
        password_confirmation: "hunter")

      u.save

      expect(u).to_not be_valid

      u.email = "sample@example.com"

      u.save

      expect(u).to be_valid
    end
  end
  describe "passwords" do 
    it "needs a paswsword and confirmation to save" do
      u = User.new(name: "steve", email: "sample@example.com")
      
      u.save
      expect(u).to_not be_valid

      u.password = "password"
      u.password_confirmation = ""
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = "password"
      u.save
      expect(u).to be_valid
    end

    it "needs password and confirmation to match" do
      u = User.create(
        name: "steve",
        email: "sample@example.com",
        password: "hunter2",
        password_confirmation: "hunter"
      )

      expect(u).to_not be_valid
    end
  end

  describe "authentication" do
    let(:user) { User.create(
      name: "steve",
      email: "sample@example.com",
      password: "hunter2",
      password_confirmation: "hunter2") }

    it "authenticates with a correct passwords" do
      expect(user.authenticate("hunter2")).to be
    end

    it "does not authenticate with an incorrect password" do
      expect(user.authenticate("hunter1")).to_not be
    end
  end

  describe "Reset user request count" do
    it "resets user request count" do
      user = FactoryGirl.create(:user)
      user.update_attribute(:request_count, 42)
      User.reset_request_count!
      user.reload
      expect(user.request_count).to eql(0)
    end
  end
end
