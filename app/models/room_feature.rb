class RoomFeature < ApplicationRecord
  belongs_to :room
  
  validates  :internet, :airConditioned, :bathroom, :furnished, :roomCleaning, presence: true
end
