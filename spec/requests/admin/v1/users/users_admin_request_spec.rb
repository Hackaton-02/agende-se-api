require 'rails_helper'

RSpec.describe "Admin::V1::Users", type: :request do
    let!(:login_user) { create(:user) }

    context "GET /users" do
     let(:url) { "/admin/v1/users" }
     let!(:users) { create_list(:user, 5) }
    
     it "returns all Users" do
      get url, headers: auth_header(login_user)
      expect(body_json['users'].count).to eq 5
     end

     it "returns success status" do
      get url, headers: auth_header(login_user)
      expect(response).to have_http_status(:ok)
     end 
   end
 end
