class EdxQuery

  include HTTParty

  def get_all_courses
    results = []
    EDX_PAGING_ARRAY.each { |start| results.push(request_edx_courses(start)) }
    return results
  end

  private

  def request_edx_courses(start)
    url = "https://www.edx.org/api/v2/report/course-feed/rss" + start
    response = HTTParty.get(url)
    page_hash = Crack::XML.parse(response.body)
    page_hash["rss"]["channel"]["item"]
  end

  EDX_PAGING_ARRAY = ["",
    "?page=1",
    "?page=2",
    "?page=3",
    "?page=4",
    "?page=5",
    "?page=6",
    "?page=7",
    "?page=8",
    "?page=9"]
end
