describe ::SalesReport::Step::ParseEntry do
  subject { described_class.call(raw: raw) }
  describe '#call!' do
    context 'successful use case when' do
      it 'returns a success :parsed with payload object'
    end

    context 'fails use case when' do
      context ':raw is not an String' do
        it 'returns a failure :invalid_attributes'
      end

      context 'cannot validate headers' do
        it 'returns an failure :invalid_headers with errors object'
      end

      context 'cannot validate data' do
        it 'returns an failure :invalid_data with errors object'
      end

      context 'cannot set payload' do
        it 'returns an failure'
      end
    end
  end
end
