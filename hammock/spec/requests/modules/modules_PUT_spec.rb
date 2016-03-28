describe 'Modules API' do

  describe 'PUT /course_modules/:id' do

    it "updates a course" do
      user = FactoryGirl.create :user
      course = FactoryGirl.build :course
      course.user_id = user.id
      course.save
      course_module = FactoryGirl.build :course_module
      course_module.course_id = course.id
      course_module.save
      auth_headers = user.create_new_auth_token
      auth_headers["Content-Type"] = 'application/json'
      course_module_params = {
        "course_module" => {
          "id": course_module.id,
          "title": course_module.title,
          "complete": true
        }
      }.to_json
      put "/course_modules/#{course_module.id}", course_module_params, auth_headers
      expect(response.status).to eq 201
      expect(CourseModule.last.id).to eq course_module.id
      expect(CourseModule.last.complete).to eq true
    end

  end
end
