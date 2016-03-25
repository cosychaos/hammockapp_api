FactoryGirl.define do
  factory :course do
    provider "Coursera"
    name "Ruby"
    description "Program in Ruby"
    organisation "ANUx"
    image "/c4x/ANUx/ANU-INDIA1x/asset/homepage_course_image.jpg"
    url "https://courses.edx.org/api/course_structure/v0/courses/ANUx/ANU-INDIA1x/1T2014/"
    duration "3 months"
    startdate "2016-03-23T00:00:00.000Z"
    enddate "2016-06-23T00:00:00.000Z"

  end
end
