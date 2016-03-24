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
end
