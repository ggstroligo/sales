require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build :product }

  context 'Validations' do
    it '#merchant' do
      is_expected.to validate_presence_of(:merchant_id)
    end

    it '#description' do
      is_expected.to validate_uniqueness_of(:description).scoped_to(:merchant_id, :price)
      is_expected.to validate_presence_of(:description)
    end
  end

  context 'Relationships' do
    it { is_expected.to belong_to(:merchant) }
  end
end
