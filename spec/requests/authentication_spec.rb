require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:user) { create(:user) }
  let(:valid_user_credentials) {
    {
      email: user.email,
      name: user.name,
      password: user.password
    }
  }.to_json

  let(:invalid_user_credentials) {
    {
      email: 'another@email.com',
      name: 'Jackie',
      password: 'password'
    }
  }.to_json

  describe 'sign in via post /authenticate' do
    context 'success' do 
      before { post '/authenticate', params: valid_user_credentials }

      it 'respond with 200 status' do 
        expect(response).to have_http_status(200)
      end

      it 'return auth token' do 
        expect(json[:auth_token]).not_to be_nil
      end

      it 'return message' do 
        expect(json[:message]).to eq('Logged In Successfully!')
      end
    end

    context 'failure' do 
      before { post '/authenticate', params: invalid_user_credentials }

      it 'respond with 401 status' do 
        expect(response).to have_http_status(401)
      end

      it 'return auth token' do 
        expect(json[:auth_token]).to be_nil
      end

      it 'return message' do 
        expect(json[:message]).to eq('Log in failed')
      end
    end
  end
end
