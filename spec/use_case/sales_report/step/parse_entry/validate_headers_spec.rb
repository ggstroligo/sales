require 'rails_helper'

describe ::SalesReport::Step::ParseEntry::ValidateHeaders do
  subject { described_class.call(headers: headers) }

  describe '#call!' do
    context 'successful use case when' do
      it 'returns a success :valid_headers'
    end

    context 'fails use case when' do
      context ':headers is not an Array' do
        it 'returns a failure :invalid_attributes' 
      end

      context ':headers contains errors' do
        it 'returns an failure :invalid_headers with errors object'
      end
    end
  end
end
