require 'rails_helper'

RSpec.describe "Especialista::V1::BookingValidations", type: :request do
    let!(:login_user) { create(:user) }
    let(:room) { create(:room) }
    let!(:rent) { create(:room_rent, started_at: 1.day.from_now, finish_at: 4.days.from_now, room_id: room.id)}
    let(:url) { "/especialista/v1/rooms_rent/#{room.id}/booked" }


    it 'returns last added Room' do
     get url, headers: auth_header(login_user)
     expected_return = build(RoomRent.last)
     expect(body_json).to eq expected_return
    end
   
    it "returns all dates" do
     get url, headers: auth_header(login_user)
     expect(body_json.count).to eq 1
    end
   
    it "returns success status" do
     get url, headers: auth_header(login_user)
     expect(response).to have_http_status(:ok)
    end 

  def build(rent)
    array = []
    json = rent.as_json(only: %i[range]).to_h
    json.to_a
    json['range'] = ((rent.started_at..rent.finish_at).to_a).as_json()
    array.push(json)
    array
  end
end
