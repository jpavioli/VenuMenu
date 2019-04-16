class Attraction < ActiveRecord::Base

  self.primary_key = :id

  has_many :events
  has_many :venues, through: :events

end
