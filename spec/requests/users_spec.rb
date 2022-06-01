require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { build(:user) }
  let(:user_credentials) { 
    { email: user.email,
      name: user.name, 
      password: user.password, 
      password_confirmation: user.password }
  }.to_json

  let(:invalid_user_credentials) {
    {
      email: 'fake@email.com',
      name: 'fakename',
      password: 'foobar',
      password_confirmation: 'password'    }
  }.to_json

  describe 'signup via post /signup' do 
    context 'success' do 
      before { post '/signup', params: user_credentials }
      
      it 'respond with 201 status' do 
        expect(response).to have_http_status(201)
      end

      it 'return auth token' do 
        expect(json[:auth_token]).not_to be_nil
      end

      it 'returns message' do  
        expect(json[:message]).to eq('Account created successfully!')
      end
    end

    context 'failure' do
      before { post '/signup', params: invalid_user_credentials }
      
      it 'respond with 200 status' do 
        expect(response).to have_http_status(422)
      end

      it 'return auth token' do 
        expect(json[:auth_token]).to be_nil
      end

      it 'returns message' do  
        expect(json[:message]).to eq("Validation failed: Password confirmation doesn't match Password")
      end
    end
  end
end
