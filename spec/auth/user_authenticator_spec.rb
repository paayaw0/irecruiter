require 'rails_helper'

describe UserAuthenticator do
  let(:user) { create(:user) }
  let(:valid_auth_obj) {
      described_class.new(user.email, user.password)
  }

  let(:invalid_auth_obj) {
      described_class.new('foo', 'bar')
  }

  describe '#call' do 
    context 'success' do 
      it 'returns token' do  
        token = valid_auth_obj.call 
        expect(token).not_to be_nil
      end
    end

    context 'failure' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }.to raise_error(ExceptionHandlers::AuthenticationError, /Invalid credentials/)
      end
    end
  end
end