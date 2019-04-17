require_relative '../config/environment'
require_relative '../db/seeds'

$prompt = TTY::Prompt.new

system "clear"

#Create a Title Block

#Seed Data
puts "Greetings! What state are you in? (XX)"
stateCode = gets.chomp

#populate venues
populate_venues(create_venue_hash(get_ticketmaster_api_hash(stateCode)))
populate_attractions(create_attraction_hash(get_ticketmaster_api_hash(stateCode)))
populate_events(create_event_hash(get_ticketmaster_api_hash(stateCode)))

system "clear"

selected_venue = def select_venue
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

#selected_venue.show_attraction_types

def select_attraction
  #gets user input to select a type of event they would like to see
  attr_names = Attraction.all
  attr_selection = $prompt.select("Which attraction would you like to look at?", per_page: 20) do |menu|
    menu.enum "."
    attr_names.each_with_index do |key,value|
      menu.choice key.attraction_name, value
    end
  end
  attr_names[attr_selection]
end

def select_event
  #returns event ex: c = select_event
  events_names = Event.all
  event_selection = $prompt.select("Which event info would you like?", per_page: 20) do |menu|
    menu.enum "."
    events_names.each_with_index do |key,value|
      menu.choice key.event_name, value
    end
  end
  events_names[event_selection]
end

def display_table(array_of_objects)
  #takes an array of event objects and returns a formatted table of information
  puts "-----------------------------------------+------------+------------+-----------------------"
  puts "Event Name                               | Event Date | Event Time | CAN I GO?!?!?"
  puts "-----------------------------------------+------------+------------+-----------------------"
  array_of_objects.each do |event|
    e_name = event[:event_name].length > 35 ? event[:event_name].slice(0..34)+"...  " : event[:event_name].ljust(40, ' ')
    e_time = event[:event_time] == nil ? "        " : event[:event_time].slice(0..7)
    puts "#{e_name} | #{event[:event_date]} |  #{e_time}  | Tickets are #{event[:event_ticket_status]}"
  end
  puts "-----------------------------------------+------------+------------+-----------------------"
end

#read info from event

binding.pry

0

puts "HELLO WORLD"
