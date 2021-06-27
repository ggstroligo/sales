require 'rails_helper'

describe ::SalesReport::Step::ParseEntry::ValidateHeaders do
  subject { described_class.call(headers: headers) }

  describe '#call!' do
    context 'successful use case when' do
      let(:headers) { SALES_ENTRY_HEADERS_VALID }

      it 'returns a success :valid_headers' do
        expect(subject.success?).to be true
        expect(subject.type).to be :valid_headers
      end
    end

    context 'fails use case when' do
      context ':headers is not an Array' do
        let(:headers) { 'not a array' }

        it 'returns a failure :invalid_attributes' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_attributes
        end
      end

      context ':headers contains errors' do
        let(:headers) { SALES_ENTRY_HEADERS_INVALID }

        it 'returns an failure :invalid_headers with errors object' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_headers
        end
      end
    end
  end
end
