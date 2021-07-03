require 'rails_helper'

describe ::SalesReport::Step::PersistSaleData do
  subject { described_class.call(orders: orders) }

  describe '#call!' do
    context 'successful use case when' do
      context 'when valid orders given' do
        let(:orders) do
          [
            {
              customer: 'João Silva',
              items: [
                {
                  description: 'R$10 off R$20 of food',
                  price: Float(10),
                  amount: Integer(2),
                  merchant: {
                    address: '987 Fake St',
                    name: "Bob's Pizza"
                  }
                }
              ]
            }
          ]
        end

        it 'returns a success :persisted with sale object' do
          expect(subject.success?).to be true
          expect(subject.type).to be :persisted
          expect(subject.data[:sale]).to be_an_instance_of(Sale)
        end
      end
    end

    context 'fails use case when' do
      context ':raw is not an String' do
        let(:orders) { :not_a_enum }

        it 'returns a failure :invalid_attributes' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_attributes
        end
      end
    end
  end
end
