class Venue < ActiveRecord::Base

  self.primary_key = :id

  has_many :events
  has_many :attractions, through: :events

  # def attraction_by_venue
  #   #return all attractions
  #   self.attractions
  # end

end
