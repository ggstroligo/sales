require 'rails_helper'

describe ::SalesReport::Step::ParseEntry::BuildPayload do
  subject { described_class.call(headers: headers, data: data) }

  describe '#call!' do
    context 'successful use case when' do
      it 'returns a success :valid_entry'
    end

    context 'fails use case when' do
      context ':headers is not an Array' do
        it 'returns a failure :invalid_attributes'
      end

      context ':data is not an Array' do
        it 'returns a failure :invalid_attributes'
      end
    end
  end
end
