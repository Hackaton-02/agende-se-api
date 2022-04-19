require 'rails_helper'

RSpec.describe "Storefront::V1::Addresses", type: :request do
    let!(:login_user) { create(:user) }
    let!(:address) { create(:address) }

    context "POST /address" do
        let(:url) { "/storefront/v1/address" }
     
        context "with valid params" do
         let!(:address_params) { { address: attributes_for(:address) }.to_json }
   
         it 'adds a new Address' do
           expect do
             post url, headers: auth_header(login_user), params: address_params
           end.to change(Address, :count).by(1)
         end
   
         it 'returns last added Address' do
           post url, headers: auth_header(login_user), params: address_params
           expected_address = Address.last.as_json(
             only: %i[id number state street user_id
             city zipcode country complement]
            )
           expect(body_json['address']).to eq expected_address
         end
   
         it 'returns success status' do
           post url, headers: auth_header(login_user), params: address_params
           expect(response).to have_http_status(:ok)
         end
       end
     
        context "with invalid params" do
         let(:address_invalid_params) do 
           { address: attributes_for(:address, street: nil) }.to_json
         end
       
         it 'does not add a new Address' do
           expect do
             post url, headers: auth_header(login_user), params: address_invalid_params
           end.to_not change(Address, :count)
         end
   
         it 'returns error message' do
           post url, headers: auth_header(login_user), params: address_invalid_params
           expect(body_json['errors']['fields']).to have_key('street')
         end
   
         it 'returns unprocessable_entity status' do
           post url, headers: auth_header(login_user), params: address_invalid_params
           expect(response).to have_http_status(:unprocessable_entity)
         end
       end 
    end
end
