class CourseImporter

  def initialize(coursera_query_klass=CourseraQuery, udacity_query_klass=UdacityQuery)
    @coursera_query = coursera_query_klass.new
    @udacity_query = udacity_query_klass.new
  end

  def add_udacity_courses
    course_list = udacity_query.get_all_courses
    course_list.each do |course|
      Courseitem.find_or_create_by(provider: 'Udacity', name: course["title"], description: course["short_summary"], organisation: "Udacity", image: course["image"], url: course["homepage"], duration: course["expected_duration"].to_s + course["expected_duration_unit"])
    end
  end

  def add_coursera_courses
    responses = coursera_query.get_all_courses
    responses.each do |course_list|
      course_list.each do |course|
        Courseitem.find_or_create_by(provider: 'Coursera', name: course["name"], description: course["description"], organisation: "Coursera", image: course["photoUrl"], url: create_coursera_url(course["slug"], course["courseType"]))
      end
    end
  end

  private

  attr_reader :udacity_query, :coursera_query

  def create_coursera_url(slug, course_type)
    return "https://www.coursera.org/course/" + slug if course_type == "v1.session"
    return "https://www.coursera.org/learn/" + slug if course_type == "v2.ondemand"
  end


end
