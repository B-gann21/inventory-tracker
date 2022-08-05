require 'rails_helper'

RSpec.describe 'The Landing Page' do
  context 'when not logged in' do
    it 'should have a button to create an account' do
      visit '/'

      click_button 'Create an Account'
      expect(current_path).to eq('/users/new')
    end
  end
end
