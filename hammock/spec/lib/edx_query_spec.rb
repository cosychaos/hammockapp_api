describe 'edXQuery' do

  xdescribe '#get_all_edx_courses' do

    let(:edxquery){ EdxQuery.new }

    it 'returns a collection of 10 json responses' do
      expect(edxquery.get_all_courses.length).to eq(10)
    end

    it 'returns json responses with the correct payload' do
      first_response = edxquery.get_all_courses.first
      expect(first_response[0].has_key?("title")).to eq true
    end
  end

end
