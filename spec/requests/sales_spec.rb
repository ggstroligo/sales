require 'rails_helper'

RSpec.describe 'Sales', type: :request do
  describe '#index' do
    it 'returns http success' do
      get sales_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#new' do
    it 'returns http success' do
      get new_sale_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    let(:params) { }
    it 'returns http success' do
      post sales_path(params)
      expect(response).to have_http_status(:success)
    end
  end
end
