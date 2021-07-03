require 'rails_helper'

describe ::SalesReport::Collect do
  subject { described_class.call(raw: raw) }

  describe '#call!' do
    context 'successful use case when' do
      let(:raw) { file_fixture('valid_sales_report.tab').read }

      it 'returns a success :persisted with a result object' do
        expect(subject.success?).to be true
        expect(subject.type).to be :persisted
        expect(subject.data).to have_key :sale
        expect(subject.data[:sale]).to be_an_instance_of Sale
      end
    end

    context 'fails use case when' do
      context ':raw is not an String' do
        let(:raw) { :not_a_string }

        it 'returns a failure :invalid_attributes' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_attributes
        end
      end

      context ':headers contains errors' do
        let(:raw) { file_fixture('invalid_headers_sales_report.tab').read }

        it 'returns an failure :invalid_headers with errors object' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_headers
        end
      end

      context ':data contains errors' do
        let(:raw) { file_fixture('invalid_data_sales_report.tab').read }

        it 'returns an failure :invalid_data with errors object' do
          expect(subject.success?).to be false
          expect(subject.type).to be :invalid_data
        end
      end

    end
  end
end
