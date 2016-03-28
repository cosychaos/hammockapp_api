class CourseraQuery

  include HTTParty


  def get_all_courses
    results = []
    COURSERA_PAGING_ARRAY.each { |start| results.push(request_coursera_courses(start)) }
    return results
  end

  private

  def request_coursera_courses(start)
    url = "https://api.coursera.org/api/courses.v1/?fields=photoUrl,description,slug&" + start
    response = HTTParty.get(url)
    JSON.parse(response.body)["elements"]
  end

  COURSERA_PAGING_ARRAY = ["",
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
    "start=1800"]
end
