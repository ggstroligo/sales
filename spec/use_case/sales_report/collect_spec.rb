require 'rails_helper'

describe ::SalesReport::Collect do
  subject { described_class.call(raw: raw) }

  describe '#call!' do
    context 'successful use case when' do
      let(:raw) { file_fixture('valid_sales_report.tab').read }

      it 'returns a success :persisted with a result object'
    end

    context 'fails use case when' do
      context ':raw is not an String' do
        let(:raw) { :not_a_string }

        it 'returns a failure :invalid_attributes'
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

        it 'returns an failure :invalid_data with errors object'
      end

      context ':payload couldnt be builded' do
        it 'returns an failure :payload with errors object'
      end
    end
  end
end


