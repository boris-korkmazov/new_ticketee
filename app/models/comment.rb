class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :state

  delegate :project, :to => :ticket

  validates :text, presence: true

  after_create :set_ticket_state


  private 
    def set_ticket_state
      self.ticket.state_id = self.state_id
      self.ticket.save!
    end
end
