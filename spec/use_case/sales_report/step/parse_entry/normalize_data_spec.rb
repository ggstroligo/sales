require 'rails_helper'

describe ::SalesReport::Step::ParseEntry::NormalizeData do
  subject { described_class.call(data: data) }

  describe '#call!' do
    context 'successful use case when' do
      let(:data) { SALES_ENTRY_DATA_VALID }

      it 'returns a success :valid_entry with payload object' do
        expect(subject.success?).to be true
        expect(subject.type).to be :valid_entry
        expect(subject.data[:orders]).to match([
                                                 {
                                                   customer: 'João Silva',
                                                   items: [
                                                     {
                                                       description: 'Comida',
                                                       price: Float(15.0),
                                                       amount: Integer(10),
                                                       merchant: {
                                                         address: 'Brasil',
                                                         name: 'Restaurante'
                                                       }
                                                     }
                                                   ]
                                                 }
                                               ])
      end
    end

    context 'fails use case when' do
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
