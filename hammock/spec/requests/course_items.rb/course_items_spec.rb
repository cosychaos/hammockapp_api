describe 'Courseitems API' do

  render_views

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

  end

end
