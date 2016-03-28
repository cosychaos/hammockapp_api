# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
courses = [{
  "name": "The joy of physics",
  "provider": "Coursera",
  "status": "interested",
  "id": "1"
  },
  {
  "name": "The joy of maths",
  "provider": "Udacity",
  "status": "in progress",
  "id": "2"
  },
  {
  "name": "The joy of programming",
  "provider": "Coursera",
  "status": "complete",
  "id": "3"
  }]

course_modules = [{
    "title": "sign up for the course",
    "complete": true
  },
  {
    "title": "Complete work for week 1",
    "complete": false
  },
  {
    "title": "Read up on programming",
    "complete": false
  }]


@user = User.create!(email: 'email@email.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.zone.now, name: 'Emma' )

courses.each do |course|
  course = Course.create!(name: course[:name], provider: course[:provider], status: course[:status], user_id: @user.id)
end

course_modules.each do |course_module|
  CourseModule.create!(title: course_module[:title], complete: course_module[:complete], course_id: 2)
end
