require_relative '../config/environment'
require_relative '../db/seeds'

$prompt = TTY::Prompt.new

#Seed Data
puts "Greetings! What state are you in? (XX)"
stateCode = gets.chomp

#populate venues
populate_venues(create_venue_hash(get_ticketmaster_api_hash(stateCode)))
populate_attractions(create_attraction_hash(get_ticketmaster_api_hash(stateCode)))
populate_events(create_event_hash(get_ticketmaster_api_hash(stateCode)))

system "clear"

def select_venue
  #gets user input to select a venue and returns the
  ven_names = Venue.all
  venue_selection = $prompt.select("Which venue would you like to look at?", per_page: 20) do |menu|
    menu.enum "."
    ven_names.each_with_index do |key,value|
      menu.choice key.venue_name, value
    end
  end
  ven_names[venue_selection]
end

binding.pry

0

puts "HELLO WORLD"
