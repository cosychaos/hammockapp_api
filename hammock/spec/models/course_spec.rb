require 'rails_helper'

describe Course, type: :model do

  it { is_expected.to have_many :course_modules }

  it 'is expected to initialize with a default status of interested' do
    course = FactoryGirl.create :course
    expect(course.status).to eq ("interested")
  end

end
