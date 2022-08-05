require 'rails_helper'

RSpec.describe 'Creating a user' do
  context 'happy path' do
    it 'redirects to /items' do 
      visit '/users/new'
      fill_in :email, with: Faker::Internet.email
      password = Faker::Internet.password
      fill_in :password, with: password
      fill_in :password_confirmation, with: password
      click_button 'Submit'

      expect(current_path).to eq '/items'
      expect(page).to have_content 'My Inventory'
    end
  end

  context 'sad path' do
    before :each do
      @password = Faker::Internet.password
      @user = create(:user)
      visit '/users/new'
    end

    it 'fields can not be blank' do
      click_button 'Submit'

      expect(current_path).to eq '/'
      expect(page).to have_content 'Error: invalid credentials'
    end

    it 'email must be unique' do
      fill_in :email, with: @user.email
      fill_in :password, with: @password
      fill_in :password_confirmation, with: @password
      click_button 'Submit'

      expect(current_path).to eq '/'
      expect(page).to have_content 'Error: invalid credentials'
    end

    it 'password must match confirmation' do
      fill_in :email, with: @user.email
      fill_in :password, with: @password
      fill_in :password_confirmation, with: 'NOMATCH'
      click_button 'Submit'

      expect(current_path).to eq '/'
      expect(page).to have_content 'Error: invalid credentials'
    end
  end
end
