class Address < ApplicationRecord

    belongs_to :user

    validates :street, :number, :city, :state, :country, :zipcode, presence: true
end
