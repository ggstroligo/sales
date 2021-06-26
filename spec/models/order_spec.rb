require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { create :order}

  context 'Relationships' do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:sale) }
  end
end
