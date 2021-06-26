require 'rails_helper'

RSpec.describe Sale, type: :model do
  context 'Relationships' do
    it { is_expected.to have_many(:orders)}
  end
end
