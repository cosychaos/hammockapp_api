require 'spec_helper'

describe 'Users API'  do

  context 'registration' do

    before do
      @user_params = {
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      }
      @invalid_user_params = {
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'not a real password!'
      }

    end

    it 'registers in a user with valid inputs' do
      post '/auth', @user_params
      json = JSON.parse(response.body)
      header = response.header
      expect(response).to be_success
      expect(json['status']).to eq('success')
      expect(json['data']['email']).to eq('test@test.com')
    end

    it "doesn't register a user with invalid inputs" do
      post '/auth/sign_in', @invalid_user_params
      json = JSON.parse(response.body)
      expect(response).not_to be_success
      expect(json["errors"][0]).to eq ("Invalid login credentials. Please try again.")
    end

  end

end
