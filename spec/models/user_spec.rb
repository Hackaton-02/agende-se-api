require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:profile) }
  it { is_expected.to define_enum_for(:profile).with_values({ admin: 0, paciente: 1, especialista: 2 }) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to allow_value(%w(true false)).for(:whatsapp_avaliable) }
  it { is_expected.not_to allow_value(nil).for(:whatsapp_avaliable) }

end