# frozen_string_literal: true

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :address
  validates :name, presence: true
  validates :profile, presence: true
  enum profile: { admin: 0, paciente: 1, especialista: 2 }

end
