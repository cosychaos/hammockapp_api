require 'rails_helper'
require 'spec_helper'

describe "Course database", type: :model do
  context "Udacity" do
    it 'makes a successful call to the API' do
      expect(Courseitem.request_udacity_courses[0].has_key?("title")).to eq true
    end

    it 'populates with Udacity API data' do
      Courseitem.add_udacity_courses
      expect(Courseitem.where(name: "IntrotoComputerScience")).to exist
    end
  end

  context "Coursera" do

    it 'returns a collection of 13 json responses' do
      expect(Courseitem.get_all_coursera_courses.length).to eq(19)
    end

    it 'returns json responses with the correct payload' do
      first_response = Courseitem.get_all_coursera_courses.first
      expect(first_response[0].has_key?("name")).to eq true
    end

    it 'populates the database with Coursera API name' do
      Courseitem.add_coursera_courses
      expect(Courseitem.where(name: "Creative Programming for Digital Media & Mobile Apps")).to exist
    end

    it 'populates the database with Coursera API url' do
      Courseitem.add_coursera_courses
      expect(Courseitem.where(url: "https://www.coursera.org/course/digitalmedia")).to exist
    end
  end
end
