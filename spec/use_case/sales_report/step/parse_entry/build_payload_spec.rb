require 'rails_helper'

describe ::SalesReport::Step::ParseEntry::BuildPayload do
  subject { described_class.call(headers: headers, data: data) }

  describe '#call!' do
    context 'successful use case when' do
      let(:headers) { SALES_ENTRY_HEADERS_VALID }
      let(:data) { SALES_ENTRY_DATA_VALID }

      it 'returns a success :valid_entry with payload object' do
        expect(subject.success?).to be true
        expect(subject.type).to be :valid_entry
        expect(subject.data).to include :payload
        expect(subject.data[:payload]).to be_an_instance_of Array
        expect(subject.data[:payload]).to all(be_a(Hash))
        expect(subject.data[:payload]).to all(have_key(:purchaser_name))
        expect(subject.data[:payload]).to all(have_key(:item_description))
        expect(subject.data[:payload]).to all(have_key(:item_price))
        expect(subject.data[:payload]).to all(have_key(:purchase_count))
        expect(subject.data[:payload]).to all(have_key(:merchant_address))
        expect(subject.data[:payload]).to all(have_key(:merchant_name))

        expect { subject.data[:payload].each { |item| Float(item[:item_price]) } }.not_to raise_error
        expect { subject.data[:payload].each { |item| Integer(item[:purchase_count]) } }.not_to raise_error
      end
    end

    context 'fails use case when' do
      context ':headers is not an Array' do
        let(:headers) { 'not array' }
        let(:data) { SALES_ENTRY_DATA_VALID }

        it 'returns a failure :invalid_attributes' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_attributes
        end
      end

      context ':data is not an Array' do
        let(:headers) { SALES_ENTRY_HEADERS_VALID }
        let(:data) { 'not array' }

        it 'returns a failure :invalid_attributes' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_attributes
        end
      end
    end
  end
end
