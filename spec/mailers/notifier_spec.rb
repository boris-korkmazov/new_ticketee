require "rails_helper"

RSpec.describe Notifier, type: :mailer do
  context "comment_updated" do
    let!(:project){ FactoryGirl.create(:project) }
    let!(:ticket_owner){ FactoryGirl.create(:user) }
    let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: ticket_owner) }

    let!(:commenter) { FactoryGirl.create(:user) }
    let(:comment) do
      Comment.new(
        ticket: ticket,
        user: commenter,
        text: "Test comment"
        )
    end

    let(:email) do
      Notifier.comment_updated(comment, ticket_owner)
    end

    it "sends out an email notification about a new comment" do
      expect(email.to).to include(ticket_owner.email)
      title = "#{ticket.title} for #{project.name} has been updated."
      expect(email.body).to include(title)
      expect(email.body).to include("#{comment.user.email} wrote:")
      expect(email.body).to include(comment.text)
    end

    it "correct sets the Reply-To" do
      address = ["boriskorkmazov1989+#{project.id}+#{ticket.id}@gmail.com"]
      expect(email.reply_to).to eq address
    end
  end
end
