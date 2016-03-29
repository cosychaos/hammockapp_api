class EdxQuery

  include HTTParty

  def get_all_courses
    url = "https://www.edx.org/api/v2/report/course-feed/rss"
    response = HTTParty.get(url)
    page_hash = Crack::XML.parse(response.body)
    page_hash["rss"]["channel"]["item"]
  end
end
