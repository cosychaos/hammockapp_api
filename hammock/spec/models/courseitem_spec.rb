require 'rails_helper'
require 'spec_helper'

describe "Course database", type: :model do
  context "Udacity" do
    it 'makes a successful call to the API' do
      expect(Courseitem.request_udacity_courses[0].has_key?("title")).to eq true
    end

    it 'checks that the database is populated with Udacity API data' do
      Courseitem.add_udacity_courses
      expect(Courseitem.where(name: "IntrotoComputerScience")).to exist
    end
  end
end
