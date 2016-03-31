describe 'Modules API' do

  describe 'POST /courses/:course_id/course_modules' do


    it "adds a course" do
      user = FactoryGirl.create :user
      course = FactoryGirl.build :course
      course.user_id = user.id
      course.save
      auth_headers = user.create_new_auth_token
      auth_headers["Content-Type"] = 'application/json'
      course_module_params = {
        "course_module" => {
          "title": "Do some reading",
          "complete": false
        }
      }.to_json
      post "/courses/#{course.id}/course_modules", course_module_params, auth_headers
      expect(response.status).to eq 201
      expect(CourseModule.last.title).to eq "Do some reading"
      expect(CourseModule.last.complete).to eq false
    end

  end
end
