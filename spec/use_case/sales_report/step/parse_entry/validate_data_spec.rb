require 'rails_helper'

describe ::SalesReport::Step::ParseEntry::ValidateData do
  subject { described_class.call(data: data) }

  describe '#call!' do
    context 'successful use case when' do
      let(:data) { SALES_ENTRY_DATA_VALID }
      it 'returns a success :valid_data' do
        expect(subject.success?).to be true
        expect(subject.type).to be :valid_data
      end
    end

    context 'fails use case when' do
      context ':data is not an Array' do
        let(:data) { :not_array }
        it 'returns a failure :invalid_attributes' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_attributes
        end
      end

      context ':data contains errors' do
        let(:data) { SALES_ENTRY_DATA_INVALID }

        it 'returns an failure :invalid_data with errors object' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_data
        end
      end
    end
  end
end
