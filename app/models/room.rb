class Room < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :price, presence: true
    validates :description, presence: true

end
