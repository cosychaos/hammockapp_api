require 'spec_helper'

describe 'Users API'  do

  context 'login' do

    let!(:user){FactoryGirl.create(:user)}
    before do
      @user_params = {
        email: user.email,
        password: user.password
      }
      @invalid_user_params = {
        email: user.email,
        password: "not a real password!"
      }
    end

    it 'logs in a user with valid inputs' do
      post '/auth/sign_in', @user_params
      json = JSON.parse(response.body)
      header = response.header
      expect(response).to be_success
      expect(header.has_key?("access-token")).to eq(true)
      expect(json["data"]["email"]).to eq(user.email)
      p user
    end

    it " doesn't log in a user with invalid inputs" do
      post '/auth/sign_in', @invalid_user_params
      json = JSON.parse(response.body)
      expect(response).not_to be_success
      expect(json["errors"][0]).to eq ("Invalid login credentials. Please try again.")
    end

  end

end
