describe 'Course Populate' do

  it 'populates the database with Coursera API' do
    course_importer = CourseImporter.new
    course_importer.add_coursera_courses
    expect(Courseitem.where(name: "Creative Programming for Digital Media & Mobile Apps")).to exist
  end

  it 'populates the database with Udacity API' do
    course_importer = CourseImporter.new
    course_importer.add_udacity_courses
    expect(Courseitem.where(name: "IntrotoComputerScience")).to exist
  end

end
