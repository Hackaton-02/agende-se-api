class Consult < ApplicationRecord
  belongs_to :user
  has_one :payment, dependent: :destroy

  validates :started_at, :finish_at, presence: true, future_date: true

end
