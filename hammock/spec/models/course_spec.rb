require 'rails_helper'

describe Course, type: :model do

  it { is_expected.to have_many :course_modules }

  it 'is expected to initialize with a default status of interested' do
    course = FactoryGirl.create :course
    expect(course.status).to eq ("interested")
  end

  describe '#build_with_clone' do

    let(:user){ FactoryGirl.create :user}
    let(:courseitem) {FactoryGirl.create :courseitem}
    let(:course) { Course.build_with_clone(courseitem, user)}

    it 'builds a course' do
      expect(course).to be_a Course
    end

    it 'builds a course with attributes which are cloned from the course item' do
      expect(course.name).to eq courseitem.name
    end

    it 'adds a deafult status of interested' do
      expect(course.status).to eq 'interested'
    end

    it 'builds a course associated with the specified user' do
      expect(course.user_id).to eq user.id
    end

    context 'passed in with an in progress status' do

      let(:user){ FactoryGirl.create :user}
      let(:courseitem) {FactoryGirl.create :courseitem}
      let(:current_course) {Course.build_with_clone(courseitem, user, "in progress")}

      it 'builds a course with a status of interested' do
        expect(current_course.status).to eq "in progress"
      end

    end

  end

end
