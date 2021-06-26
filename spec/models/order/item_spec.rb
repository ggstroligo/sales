require 'rails_helper'

RSpec.describe Order::Item, type: :model do
  subject { build :order_item }

  context 'Relationships' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end
end
