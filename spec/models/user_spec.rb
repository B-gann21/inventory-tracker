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
end
