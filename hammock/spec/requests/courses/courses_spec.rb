describe "Courses API" do

  it "sends course list as json" do
    course = FactoryGirl.build :course
    user = FactoryGirl.create :user
    course.user_id = user.id
    course.save

    @auth_headers = user.create_new_auth_token

    get "/courses", {}, @auth_headers
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

    duration = body.map { |m| m["duration"] }
    expect(duration).to include '3 months'

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

    @auth_headers = user.create_new_auth_token

    get "/courses", {}, @auth_headers
    expect(response.status).to eq 200

    body = JSON.parse(response.body)
    expect(body.length).to eq (2)
  end

  it "returns an error if the user is not signed in" do
    get "/courses", {}, @auth_headers
    expect(response.status).to eq 401
  end

end
