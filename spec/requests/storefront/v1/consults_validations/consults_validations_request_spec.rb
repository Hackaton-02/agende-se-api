require 'rails_helper'

RSpec.describe "Storefront::V1::ConsultsValidations", type: :request do
    let!(:login_user) { create(:user) }
    let!(:room_rent) { create(:room_rent) }
    let!(:consult) { create(:consult, room_rent_id: room_rent.id)}
    let(:url) { "/storefront/v1/consults/#{room_rent.id}/validations" }
    

    it 'returns booked consults' do
     get url, headers: auth_header(login_user)
     expected_return = build(Consult.last)
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
    json['range'] = ((rent.started_at.to_date..rent.finish_at.to_date).to_a).as_json()
    array.push(json)
    array
  end
end
