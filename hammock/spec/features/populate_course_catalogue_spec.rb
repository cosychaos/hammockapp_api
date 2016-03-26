describe 'Course Populate' do

  it 'populates the database with Coursera API' do
    Courseitem.add_coursera_courses
    expect(Courseitem.where(url: "https://www.coursera.org/course/digitalmedia")).to exist
  end

  it 'populates the database with Udacity API' do
    Courseitem.add_coursera_courses
    expect(Courseitem.where(url: "https://www.coursera.org/course/digitalmedia")).to exist
  end

end
