class Notifier < ApplicationMailer
  default from: "boriskorkmazov1989@gmail.com"


  def comment_updated(comment, user)
    @comment = comment
    @user = user
    @ticket = comment.ticket
    @project = @ticket.project
    subject = "[ticketee] #{@project.name} - #{@ticket.title}"
    mail(to: user.email, subject: subject, reply_to: "<boriskorkmazov1989+#{@project.id}+#{@ticket.id}@gmail.com>")
  end
end
