class CreateTicketWatchersTable < ActiveRecord::Migration
  def change
    create_table :ticket_watchers, id: false do |t|
      t.references :user
      t.references :ticket
    end
  end
end
