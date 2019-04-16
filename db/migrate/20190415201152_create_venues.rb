class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues, id: false do |t|
      t.string :id, null: false  #check and see if this is the primary key
      t.string :venue_name
      t.string :venue_postalCode
      t.string :venue_city
    end
  end
end
