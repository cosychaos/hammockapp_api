class Courseitem < ActiveRecord::Base

  # FIELDS = {
  # provider:
  # name:
  # description:
  # organisation:
  # image:
  # url:
  # duration:
  # startdate:
  # enddate:
  # }

  def self.request_udacity_courses
    uri = URI.parse("https://www.udacity.com/public-api/v0/courses")

    response = Net::HTTP.get_response(uri)

    JSON.parse(response.body)["courses"]

  end

  def self.add_udacity_courses

    response = self.request_udacity_courses

    response.each do |course|
      a = Courseitem.new(provider: 'Udacity', name: course["title"], description: course["short_summary"])
      a.save
    end

  end

end
