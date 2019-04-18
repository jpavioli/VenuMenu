require 'rest-client'
require 'json'
require 'pry'

def get_ticketmaster_api_hash(stateCode)
  #make the web request / generate a request hash
  response_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?stateCode=#{stateCode}&apikey=p8gJMoKaMafRx5RcD37F6XGo9whvjrQN")
  response_hash = JSON.parse(response_string)
  response_hash["_embedded"]["events"]
end

def create_venue_hash(web_hash)
  #create a hash with only the venue data
  venue_hash = web_hash.map do |event|
    {
      id: event["_embedded"]["venues"][0]["id"],
      venue_name: event["_embedded"]["venues"][0]["name"],
      venue_postalCode: event["_embedded"]["venues"][0]["postalCode"],
      venue_city: event["_embedded"]["venues"][0]["city"]["name"],
      # venue_stateCode: event["_embedded"]["venues"][0]["state"]
    }
  end
  venue_hash.uniq
end

def create_attraction_hash(web_hash)
  #create a hash with only the attraction data
  attraction_hash = web_hash.map do |event|
    {
      id: event["_embedded"]["attractions"][0]["id"],
      attraction_name: event["_embedded"]["attractions"][0]["name"],
      attraction_primary_classification: event["_embedded"]["attractions"][0]["classifications"] == [] ? nil : event["_embedded"]["attractions"][0]["classifications"][0]["segment"]["name"],
      attraction_secondary_classification: event["_embedded"]["attractions"][0]["classifications"] == [] ? nil : event["_embedded"]["attractions"][0]["classifications"][0]["genre"]["name"],
      attraction_family_classifcation: event["_embedded"]["attractions"][0]["classifications"] == [] ? nil : event["_embedded"]["attractions"][0]["classifications"][0]["family"]
    }
  end
  attraction_hash.uniq
end

def create_event_hash(web_hash)
  #create a hash with only the event data
  event_hash = web_hash.map do |event|
    {
      id: event["id"],
      event_name: event["name"],
      event_tickets_go_on_sale: event["sales"]["public"]["startDateTime"],
      event_date: event["dates"]["start"]["localDate"],
      event_time: event["dates"]["start"]["localTime"],
      event_ticket_status: event["dates"]["status"]["code"],
      event_url: event["url"],
      venue_id: event["_embedded"]["venues"][0]["id"],
      attraction_id: event["_embedded"]["attractions"][0]["id"]
    }
  end
  event_hash
end

def populate_venues(venue_hash)
  #create presisted instances of each array element in the venue_hash
  Venue.delete_all
  venue_hash.each do |venue|
    Venue.create(venue)
  end
end

def populate_events(event_hash)
  #create presisted instances of each array element in the event_hash
  Event.delete_all
  event_hash.each do |event|
    Event.create(event)
  end
end

def populate_attractions(attraction_hash)
  #create presisted instances of each array element in the attraction_hash
  Attraction.delete_all
  attraction_hash.each do |attraction|
    Attraction.create(attraction)
  end
end
