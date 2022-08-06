require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    it { should have_secure_password }
    it { should validate_presence_of :password_digest }
  end

  context 'relationships' do
    it { should have_many :items }
  end

  context 'class methods' do
    it '.items_by_category sorts items alphabetically by category' do
      user = create(:user)
      item1 = create(:item, user: user, category: 'household/kitchen')
      item2 = create(:item, user: user, category: 'tools/hardware')
      item3 = create(:item, user: user, category: 'other')

      expect(User.items_by_category).to eq([item1, item3, item2])
    end

    it '.items_by_updated orders items by updated_at descending' do
      user = create(:user)
      item1 = create(:item, user: user, category: 'household/kitchen')
      item2 = create(:item, user: user, category: 'tools/hardware')
      item3 = create(:item, user: user, category: 'other')

      item2.update(quantity: 5)
      item1.update(quantity: 2)
      item3.update(quantity: 6)

      expect(User.items_by_updated).to eq([item3, item1, item2])
    end
  end
end
