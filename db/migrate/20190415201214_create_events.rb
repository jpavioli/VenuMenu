class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events, id: false do |t|
      t.string :id, null: false
      t.string :event_name
      t.string :event_tickets_go_on_sale
      t.string :event_date
      t.string :event_time
      t.string :event_ticket_status
      t.string :venue_id
      t.string :attraction_id
    end
  end
end
