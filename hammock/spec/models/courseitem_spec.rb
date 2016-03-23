require 'rails_helper'
require 'spec_helper'

describe Courseitem, type: :model do
  context "Udacity" do
    it 'makes a successful call to the API' do
          VCR.use_cassette("udacity_api") do
            response = Net::HTTP.get_response(URI('https://www.udacity.com/public-api/v0/courses'))
            assert_match /Example domains/, response.body
          end

      expect(response).to be_an_instance_of(String)
    end

    xit 'checks that the database is populate with Udacity API data' do
      expect
    end
  end
end
