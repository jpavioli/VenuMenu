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
  populate_tables(stateCode)
end

#populate venues

title_block

def populate_tables(state_info)
stateCode = state_info
populate_venues(create_venue_hash(get_ticketmaster_api_hash(stateCode)))
populate_attractions(create_attraction_hash(get_ticketmaster_api_hash(stateCode)))
populate_events(create_event_hash(get_ticketmaster_api_hash(stateCode)))

system "clear"
choose_search
end

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

def date_option
  date_choose = $prompt.select("How would you like to search by date?", %w(happening_today specific_date before_a_date go_back))  
   if date_choose == "happening_today"
    select_by_date(Time.now.to_s[0..9])
   elsif date_choose == "specific_date"
    entered_date = $prompt.ask("Please enter a date to search? YYYY-MM-DD:")
    select_by_date(entered_date)
   elsif date_choose == "go_back"
    choose_search
   elsif
    entered_date = $prompt.ask("Before which date? YYYY-MM-DD:")
    select_by_date("",entered_date)
   end
end

def select_by_date(date_2 , date_3 = nil, date_1 = Time.now.to_s[0..9])
  #returns all events meeting the date criteria collected
  #date_1 = after or including this date, date_2 = on this date, date_3 = before this date
  target_date_events = Event.all.select {|event| date_3 != nil && (event.event_date.to_date >= date_1.to_date && event.event_date.to_date <= date_3.to_date) || (event.event_date == date_2)}
  display_table(target_date_events)
end

def display_table(array_of_event_objects)
  #takes an array of event objects and returns a formatted table of information
  puts "---+-----------------------------------------+------------+------------+-----------------------"
  puts "ID |Event Name                               | Event Date | Event Time | Tickets Still Available?         "
  puts "---+-----------------------------------------+------------+------------+-----------------------"
  count = 1
  array_of_event_objects.each do |event|
    e_name = event[:event_name].length > 35 ? event[:event_name].slice(0..34)+"...  " : event[:event_name].ljust(40, ' ')
    e_time = event[:event_time] == nil ? "        " : event[:event_time].slice(0..7)
    puts "#{count.to_s.ljust(3,' ')}|#{e_name} | #{event[:event_date]} |  #{e_time}  | Tickets are #{event[:event_ticket_status]}"
    count += 1
  end
  puts "---+-----------------------------------------+------------+------------+-----------------------"
  final_choice = $prompt.select("What would you like to do?", %w(buy_tickets new_search exit))
    if final_choice == "search_again"
      get_state_data
    elsif final_choice == "buy_tickets"
      ticket_choice_number = ticket_choice(array_of_event_objects)
     

    else
      exit
    end

end

def ticket_choice(array)
  ticket_id = $prompt.ask("Please enter a number from the choices above:", convert: :int)
  system("open","#{array[ticket_id - 1].event_url}")
  final_choice = $prompt.select("What would you like to do?", %w(new_search exit))
  if final_choice == "new_search"
    get_state_data
  else
    exit
  end

#array_of[id-1].event_url
end




#read info from event

#-----------------------------------------------
specific_date = ""
venue = ""
event = ""
choose2 = ""

#.event_url from event hashes gives u url



def choose_search
choose = $prompt.select("How would you like to search?", %w(attractions venues date_search see_all_events go_back))
menu(choose)
end


def menu(choose)
if choose == "attractions"
  specific_date = select_attraction
  a = specific_date.events
  display_table(a)
elsif choose == "venue"
  venue = select_venue
  a = venue.events
  display_table(a)
elsif choose == "see_all_events"
  event = Event.all
  display_table(event)
elsif choose == "date_search"
  date_option
else
  get_state_data

end
end



get_state_data
