require 'rails_helper'

describe ::SalesReport::Step::ParseEntry::ValidateUncoercibleData do
  subject { described_class.call(data: data) }

  describe '#call!' do
    context 'successful use case when' do
      it 'returns a success :valid_data'
    end

    context 'fails use case when' do
      context ':data is not an Array' do
        it 'returns a failure :invalid_attributes'
      end

      context ':data contains errors' do
        it 'returns an failure :invalid_data with errors object'
      end
    end
  end
end
