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

        context 'exceeded columns' do
          let(:data) { SALES_ENTRY_DATA_INVALID_EXCEEDED_COLUMNS }

          it 'error exceeded columns' do
            expect(subject.data[:errors].first).to match({
                                                           type: 'Exceeded Columns',
                                                           expected: nil,
                                                           value: nil,
                                                           line: 0,
                                                           column: 7
                                                         })
          end
        end

        context 'invalid value type' do
          it 'error invalid type' do
            expect(subject.data[:errors]).to match [
              {
                type: 'Invalid Type',
                expected: 'Float',
                value: 'String',
                line: 0,
                column: 2
              },
              {
                type: 'Invalid Type',
                expected: 'Integer',
                value: 'String',
                line: 0,
                column: 3
              }
            ]
          end
        end
      end
    end
  end
end
