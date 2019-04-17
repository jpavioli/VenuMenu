class Venue < ActiveRecord::Base

  self.primary_key = :id

  has_many :events
  has_many :attractions, through: :events

  def show_attraction_types
    #show an array of all unique attraction types based on the venue
    self.attractions.map do |attraction|
      primary = attraction.attraction_primary_classification
      secondary = attraction.attraction_secondary_classification
      "#{primary} - #{secondary}"
    end.uniq
  end

end
