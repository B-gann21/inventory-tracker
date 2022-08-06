require 'rails_helper'

RSpec.describe 'Creating a new Item' do
    before :each do
      password = Faker::Internet.password
      @user = create(:user, password: password, password_confirmation: password)

      visit '/sessions/new'
      fill_in :email, with: @user.email
      fill_in :password, with: password
      click_button 'Log in'

      visit '/items/new'
    end

  context 'happy path' do
    it 'filling out the form creates an item and redirects to the index page' do
      expect(page).to have_field(:category, with: 'other')

      fill_in :name, with: 'Cool Item'
      select 'household/kitchen', from: :category
      uncheck :favorite
      fill_in :price, with: 5.45
      fill_in :quantity, with: 5
      click_button 'Add to Inventory'
      
      expect(current_path).to eq '/items'
      expect(page).to have_content 'Name: Cool Item'
      expect(page).to have_content 'Category: household/kitchen'
      expect(page).to have_content 'Is Favorite: false'
      expect(page).to have_content 'Price per item: 5.45'
      expect(page).to have_content 'Amount in stock: 5'
    end
  end

  context 'sad path' do
    it 'user must be logged in' do
      click_link 'Log out'
      visit '/items/new'
      fill_in :name, with: 'Cool Item'
      select 'household/kitchen', from: :category
      uncheck :favorite
      fill_in :price, with: 5.45
      fill_in :quantity, with: 5
      click_button 'Add to Inventory'
        
      expect(current_path).to eq '/'
      expect(page).to have_content 'Error: you must be logged in to view that page'
    end

    it 'fields can not be blank' do
      visit '/items/new'

      fill_in :name, with: 'Cool Item'
      click_on 'Add to Inventory'

      expect(current_path).to eq '/items'
      expect(page).to have_content 'Error: fields can not be missing'
      expect(page).to_not have_content 'Cool Item'
    end
  end
end
