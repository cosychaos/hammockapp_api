xdescribe 'UdacityQuery' do

  describe '#get_all_coursera_courses' do

    let(:udacityquery){ UdacityQuery.new }

    it 'returns json responses with the correct payload' do
      response = udacityquery.get_all_courses
      expect(response[0].has_key?("title")).to eq true
    end

  end

end
