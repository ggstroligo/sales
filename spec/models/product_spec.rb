require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Validations' do
    it '#description' do
      is_expected.to validate_uniqueness_of(:description)
      is_expected.to validate_presence_of(:description)
    end
  end

  context 'Relationships' do
    it { is_expected.to belongs_to(:merchant) }
    it { is_expected.to has_many(:order_items) }
  end
end
