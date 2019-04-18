require_relative '../config/environment'
require_relative '../db/seeds'

$prompt = TTY::Prompt.new

system "clear"

#Create a Title Block
def title_block
  #displays a fancy title block for our program
  puts "WELCOME TO... "
  puts "____   ____                     _____                        "
  puts "\\   \\ /   /____   ____  __ __  /     \\   ____   ____  __ __  "
  puts " \\   Y   // __ \\ /    \\|  |  \\/  \\ /  \\_/ __ \\ /    \\|  |  \\ "
  puts "  \\     /\\  ___/|   |  \\  |  /    Y    \\  ___/|   |  \\  |  / "
  puts "   \\___/  \\___  >___|  /____/\\____|__  /\\___  >___|  /____/  "
  puts "              \\/     \\/              \\/     \\/     \\/        "
  puts "                                          BY: MINH AND JUSTIN"
end

#Seed Data
def get_state_data
  state_abreviations = ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT', 'VT','VI','VA','WA','WV','WI','WY']
  stateCode = 'XX'
  puts "Greetings! What state are you in? (XX)"
  until state_abreviations.include?(stateCode) do
    stateCode = gets.chomp
    if !state_abreviations.include?(stateCode)
      puts "Invalid Entry, try again!"
    end
  end
  stateCode
end

#populate venues
title_block
stateCode = get_state_data
populate_venues(create_venue_hash(get_ticketmaster_api_hash(stateCode)))
populate_attractions(create_attraction_hash(get_ticketmaster_api_hash(stateCode)))
populate_events(create_event_hash(get_ticketmaster_api_hash(stateCode)))

system "clear"

def select_venue(array_of_objects = Venue.all)
  #gets user input to select a venue and returns the
  ven_names = array_of_objects
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
  #gets user input to select the name of event they would like to see
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
  #returns event
  events_names = Event.all
  event_selection = $prompt.select("Which event info would you like?", per_page: 20) do |menu|
    menu.enum "."
    events_names.each_with_index do |key,value|
      menu.choice key.event_name, value
    end
  end
  events_names[event_selection]
end

def select_by_date(date_2 , date_3 = nil, date_1 = Time.now.to_s[0..9])
  #returns all events meeting the date criteria collected
  #date_1 = after or including this date, date_2 = on this date, date_3 = before this date
  Event.all.select {|event| date_3 != nil && (event.event_date.to_date >= date_1.to_date && event.event_date.to_date <= date_3.to_date) || (event.event_date == date_2)}
end

def display_table(array_of_event_objects)
  #takes an array of event objects and returns a formatted table of information
  puts "-----------------------------------------+------------+------------+-----------------------"
  puts "Event Name                               | Event Date | Event Time | CAN I GO?!?!?         "
  puts "-----------------------------------------+------------+------------+-----------------------"
  array_of_event_objects.each do |event|
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
