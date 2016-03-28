describe 'Modules API' do

  describe 'GET /courses/:course_id/course_modules' do

    it 'returns the modules of the course' do
      user = FactoryGirl.create :user
      course = FactoryGirl.build :course
      course_module = FactoryGirl.build :course_module
      course.user_id = user.id
      course.save
      course_module.course_id = course.id
      course_module.save

      auth_headers = user.create_new_auth_token

      get "/courses/#{course.id}/course_modules", {}, auth_headers
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body[0]["title"]).to eq course_module.title
    end

    it 'returns multiple modules if a course has several modules' do
      user = FactoryGirl.create :user
      course = FactoryGirl.build :course
      course.user_id = user.id
      course.save
      course_modules = [(FactoryGirl.build :course_module), (FactoryGirl.build :course_module)]
      course_modules.each do |course_module|
        course_module.course_id = course.id
        course_module.save
      end
      auth_headers = user.create_new_auth_token
      get "/courses/#{course.id}/course_modules", {}, auth_headers
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body.length).to eq(2)
    end

  end

end
