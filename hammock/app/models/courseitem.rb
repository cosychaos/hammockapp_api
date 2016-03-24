class Courseitem < ActiveRecord::Base

  def self.request_udacity_courses
    uri = URI.parse("https://www.udacity.com/public-api/v0/courses")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)["courses"]
  end

  def self.add_udacity_courses
    response = self.request_udacity_courses
    response.each do |course|
      Courseitem.find_or_create_by(provider: 'Udacity', name: course["title"], description: course["short_summary"], organisation: "Udacity", image: course["image"], url: course["homepage"], duration: course["expected_duration"].to_s + course["expected_duration_unit"])
    end
  end

  def self.get_all_coursera_courses
    results = []
    COURSERA_PAGING_ARRAY.each do |start|
      results.push(request_coursera_courses(start))
    end
    return results
  end

  def self.request_coursera_courses(start)
    uri = URI.parse("https://api.coursera.org/api/courses.v1/?fields=photoUrl,description,slug" + start)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)["elements"]
  end

  def self.add_coursera_courses
    responses = get_all_coursera_courses
    responses.each do |response|
      response.each do |course|
        Courseitem.find_or_create_by(provider: 'Coursera', name: course["name"], description: course["description"], organisation: "Coursera", image: course["photoUrl"], url: create_coursera_url(course["slug"], course["courseType"]))
      end
    end
  end

  private

  COURSERA_PAGING_ARRAY = [
    "",
    "start=100",
    "start=200",
    "start=300",
    "start=400",
    "start=500",
    "start=600",
    "start=700",
    "start=800",
    "start=900",
    "start=1000",
    "start=1100",
    "start=1200",
    "start=1300",
    "start=1400",
    "start=1500",
    "start=1600",
    "start=1700",
    "start=1800"
  ]

  def self.create_coursera_url(slug, course_type)
    return "https://www.coursera.org/course/" + slug if course_type == "v1.session"
    return "https://www.coursera.org/learn/" + slug if course_type == "v2.ondemand"
  end





end
