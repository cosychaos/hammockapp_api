require 'rails_helper'

describe CourseModule, type: :model do
  it { is_expected.to belong_to :course }
end
