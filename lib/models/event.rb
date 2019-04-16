class Event < ActiveRecord::Base

  self.primary_key = :id

  belongs_to :attraction
  belongs_to :venue

end
