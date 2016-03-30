require 'rails_helper'

describe Courseitem, type: :model do

  describe '#cloned_by_current_user?' do

    let(:user) {FactoryGirl.create :user}
    let(:courseitem){ FactoryGirl.create :courseitem}


    it 'returns true if the current user has a course cloned from the courseitem' do
      course = Course.build_with_clone(courseitem, user)
      course.save
      expect(courseitem.cloned_by_current_user?(user)).to eq true
    end

    it 'returns false if the current user does not have a course cloned from the courseitem' do
      course = FactoryGirl.build :course
      course.user_id = user.id
      course.save
      expect(courseitem.cloned_by_current_user?(user)).to eq false
    end


  end



end
