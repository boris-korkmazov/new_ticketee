class CommentsController < ApplicationController
  before_action :require_signin!

  before_action :find_ticket


  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
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
    if not current_user.admin?
      if cannot?('change states'.to_sym, @ticket.project)
        params[:comment].delete(:state_id)
      end

      if cannot?(:"tag", @ticket.project)
        params[:comment].delete(:tag_names)
      end
    end

    params.require(:comment).permit(:text, :tag_names, :state_id)
  end
end
