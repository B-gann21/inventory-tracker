require 'rails_helper'

RSpec.describe Item do
  context 'validations' do
    it { should validate_presence_of :name }

    it { should validate_presence_of :quantity }
    it { should validate_numericality_of :quantity }

    it { should validate_presence_of :price }
    it { should validate_numericality_of :price }

    it { should validate_presence_of :favorite }

    it { should validate_presence_of :category }
    it { should define_enum_for(:category)
          .with_values(['food/drink', 'tools/hardware', 'household/kitchen', 'other']) }
  end

  context 'relationships' do
    it { should belong_to :user }
  end
end
