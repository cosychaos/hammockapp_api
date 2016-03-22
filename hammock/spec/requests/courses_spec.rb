describe "Courses API" do

  it "sends course list as json" do
    FactoryGirl.create :course, provider: 'Coursera', name: 'Ruby', description: 'Program in Ruby',
                      organisation: "ANUx", image: "/c4x/ANUx/ANU-INDIA1x/asset/homepage_course_image.jpg",
                      url: "https://courses.edx.org/api/course_structure/v0/courses/ANUx/ANU-INDIA1x/1T2014/",
                      duration: "3 months", startdate: "2016-03-23T00:00:00.000Z", enddate: "2016-06-23T00:00:00.000Z"
    get "/", {}, { "Accept" => "application/json" }
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

end
