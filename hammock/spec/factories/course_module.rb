FactoryGirl.define do
  factory :course_module do
    title Faker::Hipster.sentence
    complete false
  end
end
