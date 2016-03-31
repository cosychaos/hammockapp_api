require 'spec_helper'

describe 'Users API'  do

  context 'signout' do

    before do
      @user = FactoryGirl.create(:user)
      @user_params = {
        email: @user.email,
        password: @user.password
      }
      @auth_headers = @user.create_new_auth_token
    end

    it 'logs out a user with valid inputs' do
      # post '/auth/sign_in', @user_params
      delete '/auth/sign_out', {}, @auth_headers
      json = JSON.parse(response.body)
      header = response.header
      expect(response).to be_success
    end

    it "doesn't log out a user with invalid inputs" do
      delete '/auth/sign_out'
      json = JSON.parse(response.body)
      expect(response).not_to be_success
      expect(json["errors"][0]).to eq ("User was not found or was not logged in.")
    end

  end

end
