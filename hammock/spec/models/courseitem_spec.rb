require 'rails_helper'
require 'spec_helper'

describe Courseitem, type: :model do
  xit 'queries Udacity for courses' do
    uri = URI('https://www.udacity.com/public-api/v0/courses')
    expect().to be_an_instance_of(Hash)
  end
end
