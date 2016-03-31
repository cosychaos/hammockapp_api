describe "Courses API" do


  it "sends course list as json" do
    course = FactoryGirl.build :course
    user = FactoryGirl.create :user
    course.user_id = user.id
    course.save

    auth_headers = user.create_new_auth_token

    get "/courses", {}, auth_headers
    expect(response.status).to eq 200

    body = JSON.parse(response.body)
    provider = body.map { |m| m["provider"] }
    expect(provider).to include 'Coursera'

    name = body.map { |m| m["name"] }
    expect(name).to include 'Ruby'

    description = body.map { |m| m["description"] }
    expect(description).to include 'Program in Ruby'

    organisation = body.map { |m| m["organisation"] }
    expect(organisation).to include 'ANUx'

    image = body.map { |m| m["image"] }
    expect(image).to include '/c4x/ANUx/ANU-INDIA1x/asset/homepage_course_image.jpg'

    url = body.map { |m| m["url"] }
    expect(url).to include "https://courses.edx.org/api/course_structure/v0/courses/ANUx/ANU-INDIA1x/1T2014/"

    startdate = body.map { |m| m["startdate"] }
    expect(startdate).to include "2016-03-23T00:00:00.000Z"

    enddate = body.map { |m| m["enddate"] }
    expect(enddate).to include "2016-06-23T00:00:00.000Z"
  end

  it "returns more than once course when the user has more than one course" do
    user = FactoryGirl.create :user

    course1 = FactoryGirl.build :course
    course2 = FactoryGirl.build :course

    course1.user_id = user.id
    course2.user_id = user.id
    course1.save
    course2.save

    auth_headers = user.create_new_auth_token

    get "/courses", {}, auth_headers
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body.length).to eq (2)
  end

  it "returns an error if the user is not signed in" do
    get "/courses", {}
    expect(response.status).to eq 401
  end

  it "adds a course" do
    user = FactoryGirl.create :user
    courseitem = FactoryGirl.create :courseitem
    auth_headers = user.create_new_auth_token
    auth_headers["Content-Type"] = 'application/json'
    course_params = {
      "course" => {
        "id": courseitem.id
      }
    }.to_json
    post "/courses", course_params, auth_headers
    expect(response.status).to eq 201
    expect(Course.last.name).to eq courseitem.name
    expect(Course.last.provider).to eq courseitem.provider
    expect(Course.last.user_id).to eq user.id
    expect(Course.last.status).to eq 'interested'
  end

  it "adds a course with a status of in progress" do
    user = FactoryGirl.create :user
    courseitem = FactoryGirl.create :courseitem
    auth_headers = user.create_new_auth_token
    auth_headers["Content-Type"] = 'application/json'
    course_params = {
      "course" => {
        "id": courseitem.id,
        "status": "in progress"
      }
    }.to_json
    post "/courses", course_params, auth_headers
    expect(response.status).to eq 201
    expect(Course.last.name).to eq courseitem.name
    expect(Course.last.provider).to eq courseitem.provider
    expect(Course.last.user_id).to eq user.id
    expect(Course.last.status).to eq "in progress"
  end

  it "adds a course that the user has built themselves" do
    user = FactoryGirl.create :user
    auth_headers = user.create_new_auth_token
    auth_headers["Content-Type"] = 'application/json'
    course_params = {
      "course" => {
        "name": "a user course",
        "image": "some image url",
        "url": "some course url",
        "status": "in progress"
      }
    }.to_json
    post "/courses", course_params, auth_headers
    expect(response.status).to eq 201
    expect(Course.last.name).to eq "a user course"
    expect(Course.last.user_id).to eq user.id
    expect(Course.last.status).to eq "in progress"
  end

  it "doesn't create a duplicate entry if a course already exists for that user" do
    user = FactoryGirl.create :user
    courseitem = FactoryGirl.create :courseitem
    course = Course.build_with_clone(courseitem, user)
    course.save

    auth_headers = user.create_new_auth_token
    auth_headers["Content-Type"] = 'application/json'
    course_params = {
      "course" => {
        "id": courseitem.id,
        "status": "in progress"
      }
    }.to_json
    post "/courses", course_params, auth_headers
    expect(response.status).to eq 201

    expect(Course.where(name: courseitem.name).length).to eq 1
    expect(Course.where(name: courseitem.name).first.status).to eq "interested"
  end

  it "updates a course" do
    user = FactoryGirl.create :user
    course = FactoryGirl.build :course
    course.user_id = user.id
    course.save
    auth_headers = user.create_new_auth_token
    auth_headers["Content-Type"] = 'application/json'
    course_params = {
      "course":{
        "provider": "Coursera",
        "name": "Ruby",
        "description": "Program in Ruby",
        "organisation": "ANUx",
        "image": "/c4x/ANUx/ANU-INDIA1x/asset/homepage_course_image.jpg",
        "url": "https://courses.edx.org/api/course_structure/v0/courses/ANUx/ANU-INDIA1x/1T2014/",
        "status": "in progress",
        "id": course.id
      }
    }.to_json
    put "/courses/#{course.id}", course_params, auth_headers
    expect(response.status).to eq 201
    expect(Course.find(course.id).status).to eq "in progress"
  end

end
