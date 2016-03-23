require 'rails_helper'
require 'spec_helper'

describe Courseitem, type: :model do
  describe "Udacity", :vcr do
    it 'makes a successful call to the API' do
      expect(Courseitem.request_udacity_courses).to be_an_instance_of(Hash)
    end

    it 'checks that the database is populate with Udacity API data' do
      expect{Courseitem.add_udacity_courses}.to change {Courseitem.count}
    end
  end
end
