class TicketsSweeper < ApplicationController::Caching::Sweeper
  observe Ticket

  def after_create(ticket)
    expire_fragment(/projects\/#{project.id}\/.*?/)
  end
end