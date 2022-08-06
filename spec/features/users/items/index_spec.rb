require 'rails_helper'

RSpec.describe 'A User Items Index page' do
  context 'happy path' do
    before :each do
      password = Faker::Internet.password
      @user = create(:user, password: password, password_confirmation: password)
      @item1 = create(:item, user_id: @user.id)
      @item2 = create(:item, user_id: @user.id)
      @item3 = create(:item, user_id: @user.id)

      visit '/sessions/new'
      fill_in :email, with: @user.email
      fill_in :password, with: password
      click_button 'Log in'
    end

    it 'shows all items with their attributes nearby' do
      within "item-#{@item1.id}" do
        expect(page).to have_content "Name: #{@item1.name}"
        expect(page).to have_content "Category: #{@item1.category}"
        expect(page).to have_content "Favorite: #{@item1.favorite}"
        expect(page).to have_content "Amount in stock: #{@item1.quantity}"
        expect(page).to have_content "Price per item: #{@item1.price}"
      end

      within "item-#{@item2.id}" do
        expect(page).to have_content "Name: #{@item2.name}"
        expect(page).to have_content "Category: #{@item2.category}"
        expect(page).to have_content "Favorite: #{@item2.favorite}"
        expect(page).to have_content "Amount in stock: #{@item2.quantity}"
        expect(page).to have_content "Price per item: #{@item2.price}"
      end

      within "item-#{@item3.id}" do
        expect(page).to have_content "Name: #{@item3.name}"
        expect(page).to have_content "Category: #{@item3.category}"
        expect(page).to have_content "Favorite: #{@item3.favorite}"
        expect(page).to have_content "Amount in stock: #{@item3.quantity}"
        expect(page).to have_content "Price per item: #{@item3.price}"
      end
    end
  end
end
