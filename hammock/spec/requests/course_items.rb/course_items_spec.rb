describe 'Courseitems API' do


  describe 'GET /courseitems' do

    it 'returns a JSON payload of course items' do
      user = FactoryGirl.create :user
      courseitem = FactoryGirl.create :courseitem
      auth_headers = user.create_new_auth_token

      get "/courseitems", {}, auth_headers
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      provider = body.map { |m| m["provider"] }
      expect(provider).to include courseitem.provider
    end

    it 'returns all courseitems in the database' do
      user = FactoryGirl.create :user
      courseitem_one = FactoryGirl.create :courseitem
      courseitem_two = FactoryGirl.create :courseitem
      auth_headers = user.create_new_auth_token

      get "/courseitems", {}, auth_headers
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body.length).to eq((Courseitem.all.count))
    end

    it 'returns all courseitems with a cloned status' do
      user = FactoryGirl.create :user
      courseitem = FactoryGirl.create :courseitem
      courseitem_uncloned = FactoryGirl.create :courseitem
      course_one = Course.build_with_clone(courseitem, user)
      course_one.save
      auth_headers = user.create_new_auth_token

      get "/courseitems", {}, auth_headers
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      p body
      expect(body[0]["cloned"]).to eq true
      expect(body[1]["cloned"]).to eq true
    end

  end

end
