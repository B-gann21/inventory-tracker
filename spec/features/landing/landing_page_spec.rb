require 'rails_helper'

RSpec.describe 'The Landing Page' do
  context 'when not logged in' do
    it 'should have a button to create an account' do
      visit '/'

      click_button 'Create an Account'
      expect(current_path).to eq('/users/new')
    end

    it 'should have a button to login' do
      visit '/'

      click_button 'Log in'
      expect(current_path).to eq('/sessions/new')
    end
  end

  context 'when logged in' do
    it 'has a button to log out' do
      password = Faker::Internet.password
      user = create(:user, password: password, password_confirmation: password)

      visit '/sessions/new'
      fill_in :email, with: user.email
      fill_in :password, with: password
      click_button 'Log in'
      visit '/'

      expect(page).to_not have_button 'Log in'
      expect(page).to_not have_button 'Create an Account'
      
      click_on 'Log out'
      expect(current_path).to eq '/'
      expect(page).to have_button 'Log in'
      expect(page).to have_button 'Create an Account'
    end
  end
end
