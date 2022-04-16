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
   
    context "POST /users" do
     let(:url) { "/admin/v1/users" }
  
     context "with valid params" do
      let(:user_params) { { user: attributes_for(:user) }.to_json }

      it 'adds a new User' do
        expect do
          post url, headers: auth_header(login_user), params: user_params
        end.to change(User, :count).by(1)
      end

      it 'returns last added User' do
        post url, headers: auth_header(login_user), params: user_params
        expected_user = User.last.as_json(
          only: %i(id name email profile)
        )
        expect(body_json['user']).to eq expected_user
      end

      it 'returns success status' do
        post url, headers: auth_header(login_user), params: user_params
        expect(response).to have_http_status(:ok)
      end
    end
  
     context "with invalid params" do
      let(:user_invalid_params) do 
        { user: attributes_for(:user, name: nil) }.to_json
      end
    
      it 'does not add a new User' do
        expect do
          post url, headers: auth_header(login_user), params: user_invalid_params
        end.to_not change(User, :count)
      end

      it 'returns error message' do
        post url, headers: auth_header(login_user), params: user_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(login_user), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end 

    context "PATCH /users/:id" do
      let(:user) { create(:user) }
      let(:url) { "/admin/v1/users/#{user.id}" }

      context "with valid params" do
        let(:new_name) { 'Johnny Brown' }
        let(:user_params) { { user: attributes_for(:user, name: new_name) }.to_json }

        it 'updates User' do
          patch url, headers: auth_header(login_user), params: user_params
          user.reload
          expect(user.name).to eq new_name
        end

        it 'returns updated User' do
          patch url, headers: auth_header(login_user), params: user_params
          user.reload
          expected_user = user.as_json(only: %i(id name email profile))
          expect(body_json['user']).to eq expected_user
        end

        it 'returns success status' do
          patch url, headers: auth_header(login_user), params: user_params
          expect(response).to have_http_status(:ok)
        end
      end
    
      context "with invalid params" do
        let(:user_invalid_params) do 
          { user: attributes_for(:user, name: nil) }.to_json
      end

      it 'does not update User' do
        old_name = user.name
        patch url, headers: auth_header(login_user), params: user_invalid_params
        user.reload
        expect(user.name).to eq old_name
      end

      it 'returns error message' do
        patch url, headers: auth_header(login_user), params: user_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        patch url, headers: auth_header(login_user), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "DELETE /categories/:id" do
      let!(:user) { create(:user) }
      let(:url) { "/admin/v1/users/#{user.id}" }

      it 'removes User' do
        expect do  
          delete url, headers: auth_header(login_user)
        end.to change(User, :count).by(-1)
      end

      it 'returns success status' do
        delete url, headers: auth_header(login_user)
        expect(response).to have_http_status(:no_content)
      end

      it 'does not return any body content' do
        delete url, headers: auth_header(login_user)
        expect(body_json).to_not be_present
      end

      # it 'removes all associated with user' do
      #   product_categories = create_list(:product_category, 3, category: category)
      #   delete url, headers: auth_header(user)
      #   expected_product_categories = ProductCategory.where(id: product_categories.map(&:id))
      #   expect(expected_product_categories.count).to eq 0
      # end

      # it 'does not remove unassociated product categories' do
      #   product_categories = create_list(:product_category, 3)
      #   delete url, headers: auth_header(user)
      #   present_product_categories_ids = product_categories.map(&:id)
      #   expected_product_categories = ProductCategory.where(id: present_product_categories_ids)
      #   expect(expected_product_categories.ids).to contain_exactly(*present_product_categories_ids)
      # end

    end
  end
end