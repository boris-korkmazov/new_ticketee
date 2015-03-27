class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :state
  belongs_to :previous_state, :class_name=>"State"

  delegate :project, :to => :ticket

  validates :text, presence: true

  after_create :set_ticket_state

  before_create :set_previous_state

  private 
    def set_ticket_state
      self.ticket.state_id = self.state_id
      self.ticket.save!
    end

    def set_previous_state
      self.previous_state = ticket.state
    end
end
