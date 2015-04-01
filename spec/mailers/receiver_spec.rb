require "rails_helper"

RSpec.describe Receiver, type: :mailer do
  let!(:ticket_owner) { FactoryGirl.create(:user, email: "user@ticketee.com") }
  let!(:project) {FactoryGirl.create(:project)}
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: ticket_owner) }
  let!(:commenter) { FactoryGirl.create(:user, name: "commenter") }
  let(:comment) {
    Comment.new(ticket: ticket, user: commenter, text: "Test comment")
  }


  it "parses a reply from a comment update into a comment" do
    email = Notifier.comment_updated(comment,  ticket_owner)
    mail = Mail.new(from: "user@ticketee.com",
      subject: "Re: #{email.subject}", body: %Q{This is a brand new comment 
        #{email.body}}, to: email.reply_to)

    expect(lambda { Receiver.parse(mail)}).to change(comment.ticket.comments, :count).by(1)
    expect(ticket.comments.last.text).to eql("This is a brand new comment")
  end
end