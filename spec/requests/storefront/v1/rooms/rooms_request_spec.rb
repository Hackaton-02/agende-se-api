require 'rails_helper'

RSpec.describe "Storefront::V1::Rooms", type: :request do
    let!(:login_user) { create(:user) }

    context "GET /rooms" do
     let(:url) { "/storefront/v1/rooms" }
     let!(:rooms) { create_list(:room, 5) }
    
     it "returns all Rooms" do
      get url, headers: auth_header(login_user)
      expect(body_json['rooms'].count).to eq 5
     end

     it "returns success status" do
      get url, headers: auth_header(login_user)
      expect(response).to have_http_status(:ok)
     end 
   end

   context "GET /room/:id" do
    let!(:room_feature) { create(:room_feature) }
    let!(:room) { create(:room, bathroom: room_feature.bathroom, airConditioned: room_feature.airConditioned, furnished: room_feature.furnished, internet: room_feature.internet, roomCleaning: room_feature.roomCleaning) }

    let(:url) { "/storefront/v1/rooms/#{room.id}" }

    it "returns requested Room" do
      get url, headers: auth_header(login_user)
      expected_room = build_room_structure(room, room_feature)
      expect(body_json).to eq expected_room
    end

    it "returns success status" do
      get url, headers: auth_header(login_user)
      expect(response).to have_http_status(:ok)
    end
  end

  def build_room_structure(room, features) 
      json = room.as_json(only: %i[id name avaliable price description])
      json['features'] = features.as_json(only: %i[airConditioned bathroom furnished internet roomCleaning])
      json
  end
end
