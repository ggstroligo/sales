require 'rails_helper'

describe ::SalesReport::Collect do
  subject { described_class.call(raw: raw) }

  describe '#call!' do
    context 'successful use case when' do
      it 'returns a success :persisted with a result object'
    end

    context 'fails use case when' do
      context ':raw is not an String' do
        it 'returns a failure :invalid_attributes'
      end

      context ':headers contains errors' do
        it 'returns an failure :invalid_headers with errors object'
      end

      context ':data contains errors' do
        it 'returns an failure :invalid_data with errors object'
      end

      context ':payload couldnt be builded' do
        it 'returns an failure :payload with errors object'
      end
    end
  end
end
