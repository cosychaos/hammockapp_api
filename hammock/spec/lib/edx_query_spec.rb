describe 'edXQuery' do

  describe '#get_all_edx_courses' do

    let(:edxquery){ EdxQuery.new }

    it 'returns json responses with the correct payload' do
      response = edxquery.get_all_courses
      expect(response[0].has_key?("title")).to eq true
    end

  end

end
