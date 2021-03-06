require 'rails_helper'

RSpec.describe 'Sales', type: :request do
  describe '#index' do
    before { get sales_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#new' do
    before { get new_sale_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do

    before do
      sale = create :sale
      customer = create :customer
      order = create :order, sale: sale, customer: customer
      merchant = create :merchant
      product = create :product, merchant: merchant, price: 10.0
      create :order_item, product: product, order: order, amount: 1

      get sale_path(sale.id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    before { post sales_path, params: { report_file: Rack::Test::UploadedFile.new(file) } }

    context 'with a invalid sales report' do
      let(:file) { file_fixture('invalid_headers_sales_report.tab') }

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_sale_path)
      end
    end

    context 'with a valid report' do
      let(:file) { file_fixture('valid_sales_report.tab') }

      it 'returns http success' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(sales_path)
      end
    end
  end
end
