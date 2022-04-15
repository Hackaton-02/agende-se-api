class Room < ApplicationRecord
    has_one :room_feature
    
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :description, :avaliable, presence: true

end
