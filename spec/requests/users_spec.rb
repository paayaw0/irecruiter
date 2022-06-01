require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { build(:user) }
  let(:user_credentials) { 
    { email: user.email,
      name: user.name, 
      password: user.password, 
      password_confirmation: user.password }
  }.to_json

  describe 'signup via post /signup' do 
    before { post '/signup', params: user_credentials }
    
    it 'respond with 200 status' do 
      expect(response).to have_http_status(200)
    end

    it 'return created user' do 
      response_body = HashWithIndifferentAccess.new(JSON.parse(response.body))
      expect(response_body[:user]['email']).to eq(user.email)
    end
  end
end
