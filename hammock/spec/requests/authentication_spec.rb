require 'spec_helper'

describe 'Users API'  do

  context 'login' do

    before do
      @user = FactoryGirl.create(:confirmed_user)
      @user_params = {
        "user" => {
          "email" => @user.email,
          "password" => @user.password
        }
      }.to_json
    end

    it 'logs in a user with valid inputs' do
      @user = FactoryGirl.create(:confirmed_user)
      post '/auth/sign_in', @user_params
      json = JSON.parse(response.body)
      expect(response).to be_success
      # expect(json[0]["question"]["id"]).to eq("test_question.id")
    end

  end

end
