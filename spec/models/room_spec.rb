require 'rails_helper'

RSpec.describe Room, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:description) }
end
