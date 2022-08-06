require 'rails_helper'

RSpec.describe 'A User Items Index page' do
  context 'happy path' do
    before :each do
      password = Faker::Internet.password
      @user = create(:user, password: password, password_confirmation: password)
      @item1 = create(:item, user_id: @user.id, category: 'tools/hardware')
      @item2 = create(:item, user_id: @user.id, category: 'household/kitchen')
      @item3 = create(:item, user_id: @user.id, category: 'food/drink')

      visit '/sessions/new'
      fill_in :email, with: @user.email
      fill_in :password, with: password
      click_button 'Log in'
    end

    it 'shows all items with their attributes nearby' do
      within "#item-#{@item1.id}" do
        expect(page).to have_content "Name: #{@item1.name}"
        expect(page).to have_content "Category: #{@item1.category}"
        expect(page).to have_content "Favorite: #{@item1.favorite}"
        expect(page).to have_content "Amount in stock: #{@item1.quantity}"
        expect(page).to have_content "Price per item: #{@item1.price}"
      end

      within "#item-#{@item2.id}" do
        expect(page).to have_content "Name: #{@item2.name}"
        expect(page).to have_content "Category: #{@item2.category}"
        expect(page).to have_content "Favorite: #{@item2.favorite}"
        expect(page).to have_content "Amount in stock: #{@item2.quantity}"
        expect(page).to have_content "Price per item: #{@item2.price}"
      end

      within "#item-#{@item3.id}" do
        expect(page).to have_content "Name: #{@item3.name}"
        expect(page).to have_content "Category: #{@item3.category}"
        expect(page).to have_content "Favorite: #{@item3.favorite}"
        expect(page).to have_content "Amount in stock: #{@item3.quantity}"
        expect(page).to have_content "Price per item: #{@item3.price}"
      end
    end
  
    describe 'sorting items' do
      it 'can be sorted by category' do
        click_on 'Sort by Category'
        
        expect(current_path).to eq '/items'

        expect(@item3.name).to appear_before @item2.name
        expect(@item2.name).to appear_before @item1.name
        expect(@item1.name).to_not appear_before(@item3.name)
        expect(@item1.name).to_not appear_before(@item2.name)
      end
      
      it 'can be sorted by updated_at' do
        @item2.update(quantity: 500)
        @item3.update(quantity: 500)
        @item1.update(quantity: 500)

        click_on 'Sort by most recently updated'
        expect(current_path).to eq '/items'

        expect(@item1.name).to appear_before @item3.name
        expect(@item3.name).to appear_before @item2.name
        expect(@item2.name).to_not appear_before @item1.name
        expect(@item2.name).to_not appear_before @item2.name
      end
    end
  end
end
