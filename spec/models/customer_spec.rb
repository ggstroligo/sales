require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'Validations' do
    it '#name' do
      is_expected.to validate_uniqueness_of(:name)
      is_expected.to validate_presence_of(:name)
    end
  end

  context 'Relationships' do
    it { is_expected.to have_many(:purchases) }
  end
end
