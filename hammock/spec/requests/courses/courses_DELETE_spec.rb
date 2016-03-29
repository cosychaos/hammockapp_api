describe 'Courses API' do

  describe 'DELETE /courses/:id' do

    it "deletes a course" do
      user = FactoryGirl.create :user
      course = FactoryGirl.build :course
      course.user_id = user.id
      course.save
      auth_headers = user.create_new_auth_token
      auth_headers["Content-Type"] = 'application/json'
      course_params = {
        "course":{
          "id": course.id
        }
      }.to_json
      delete "/courses/#{course.id}", course_params, auth_headers
      expect(response.status).to eq 204
      expect(Course.exists?(course.id)).to eq false
    end

  end

end
