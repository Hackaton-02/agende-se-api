require 'rails_helper'

RSpec.describe RoomFeature, type: :model do
  it { is_expected.to validate_presence_of(:internet) }
  it { is_expected.to validate_presence_of(:airConditioned) }
  it { is_expected.to validate_presence_of(:bathroom) }
  it { is_expected.to validate_presence_of(:furnished) }
  it { is_expected.to validate_presence_of(:roomCleaning) }
  it { is_expected.to belong_to :room }

end
