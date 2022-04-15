class Consult < ApplicationRecord
  belongs_to :user
  has_one :payment

  validates :started_at, :finish_at, presence: true, future_date: true

end
