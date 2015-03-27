class CommentsController < ApplicationController
  before_action :require_signin!

  before_action :find_ticket


  def create
    @comment = @ticket.comments.build(comment_params)
    p @comment
    @comment.user = current_user
    if @comment.save
      @ticket.reload
      redirect_to [@ticket.project, @ticket], notice: "Comment has been created."
    else
      @states = State.all
      flash.now[:alert] = "Comment has not been created."
      render :template => "tickets/show"
    end
  end

  private

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :state_id)
  end
end
