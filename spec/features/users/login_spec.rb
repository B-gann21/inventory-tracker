require 'rails_helper'

RSpec.describe 'Logging in a User' do
  before :each do
    @password = Faker::Internet.password
    @user = create(:user, password: @password, password_confirmation: @password)
  end

  context 'happy path' do
    it 'redirects to /items' do
      visit '/sessions/new'
      fill_in :email, with: @user.email
      fill_in :password, with: @password
      click_button 'Log in'

      expect(current_path).to eq '/items'
    end
  end

  context 'sad path' do
    it 'fields can not be blank' do
      visit '/sessions/new'
      fill_in :email, with: @user.email
      click_button 'Log in'

      expect(current_path).to eq '/sessions/new'
      expect(page).to have_content 'Error: invalid credentials'
    end

    it 'invalid email' do
      visit '/sessions/new'
      fill_in :email, with: 'NOMATCH'
      fill_in :password, with: @password
      click_button 'Log in'

      expect(current_path).to eq '/sessions/new'
      expect(page).to have_content 'Error: invalid credentials'
    end

    it 'invalid password' do
      visit '/sessions/new'
      fill_in :email, with: @user.email
      fill_in :password, with: 'NOMATCH'
      click_button 'Log in'

      expect(current_path).to eq '/sessions/new'
      expect(page).to have_content 'Error: invalid credentials'
    end
  end
end
