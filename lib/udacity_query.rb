class UdacityQuery

  include HTTParty

  def get_all_courses
    url = "https://www.udacity.com/public-api/v0/courses"
    response = HTTParty.get(url)
    JSON.parse(response.body)["courses"]
  end

end
