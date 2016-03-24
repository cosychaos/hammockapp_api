class Courseitem < ActiveRecord::Base

  def self.request_udacity_courses
    uri = URI.parse("https://www.udacity.com/public-api/v0/courses")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)["courses"]
  end

  def self.add_udacity_courses
    response = self.request_udacity_courses
    response.each do |course|
      a = Courseitem.new(provider: 'Udacity', name: course["title"], description: course["short_summary"], organisation: "Udacity", image: course["image"], url: course["homepage"], duration: course["expected_duration"].to_s + course["expected_duration_unit"])
      a.save
    end
  end

  def self.request_coursera_courses(start)
    uri = URI.parse("https://api.coursera.org/api/courses.v1/?fields=photoUrl,description,slug" + start)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)["elements"]
  end

  def self.add_coursera_courses
    response = self.request_coursera_courses
    response.each do |course|
      a = Courseitem.new(provider: 'Coursera', name: course["name"], description: course["description"], organisation: "Coursera", image: course["photoUrl"], url: create_coursera_url(course["slug"], course["courseType"]))
      a.save
    end
  end


  private
  def self.create_coursera_url(slug, course_type)
    return "https://www.coursera.org/course/" + slug if course_type == "v1.session"
    return "https://www.coursera.org/learn/" + slug if course_type == "v2.ondemand"
  end

end
