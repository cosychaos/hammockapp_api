require 'spec_helper'

describe 'Users API'  do

  context 'signout' do

    before do
      @user = FactoryGirl.create(:user)
      @user_params = {
        email: @user.email,
        password: @user.password
      }
    end

    it 'logs out a user with valid inputs' do
      post '/auth/sign_in', @user_params
      delete '/auth/sign_out'
      json = JSON.parse(response.body)
      header = response.header
    end

    # it " doesn't log in a user with invalid inputs" do
    #   post '/auth/sign_in', @invalid_user_params
    #   json = JSON.parse(response.body)
    #   expect(response).not_to be_success
    #   expect(json["errors"][0]).to eq ("Invalid login credentials. Please try again.")
    # end

  end

end
