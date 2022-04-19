class Room < ApplicationRecord
    include LikeSearchable
    include Paginatable

    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :description, presence: true
    validates  :internet, :avaliable, :airConditioned, :bathroom, :furnished, :roomCleaning, inclusion: { in: [ true, false ] }
end
