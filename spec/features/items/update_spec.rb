require 'rails_helper'

RSpec.describe 'Updating an Item' do
  before :each do
    password = Faker::Internet.password
    @user = create(:user, password: password, password_confirmation: password)
    @item = create(:item, user: @user, name: 'Pencil Box', quantity: 5)

    visit '/sessions/new'
    fill_in :email, with: @user.email
    fill_in :password, with: password
    click_on 'Log in'
  end

  context 'happy path' do
    it 'has a link to update attributes' do
      expect(page).to have_content 'Pencil Box'
      expect(page).to have_content 'Edit name, price, or category'

      click_on 'Edit'
      expect(current_path).to eq "/items/#{@item.id}/edit"
      fill_in :name, with: 'Eraser'
      fill_in :price, with: 5.00
      select 'other', from: :category
      click_on 'Update Item'

      expect(current_path).to eq '/items'
      expect(page).to_not have_content 'Pencil Box'
      expect(page).to have_content 'Eraser'
      expect(page).to have_content 'Category: other'
      expect(page).to have_content 'Price: 5.0'
    end

    it 'can add to stock with a number field' do
      expect(page).to have_content 'Amount in stock: 5'
      expect(page).to have_field :quantity
      fill_in :quantity, with: 5
      click_on 'Add to stock'

      expect(current_path).to eq '/items'
      expect(page).to have_content 'Amount in stock: 10'
    end

    it 'can remove from stock with a number field' do
      expect(page).to have_content 'Amount in stock: 5'
      fill_in :quantity, with: 5
      click_on 'Remove from stock'

      expect(current_path).to eq '/items'
      expect(page).to have_content 'Amount in stock: 0'
    end

    describe 'adding/removing favorite status' do
      it 'if favorited, has a button to remove favorite' do
        @item.update(favorite: true)
        visit '/items'
        expect(page).to have_content 'Is favorite: true'

        click_on 'Remove from favorites'
        expect(current_path).to eq '/items'
        expect(page).to have_content 'Is Favorite: false'
      end

      it 'if not favorited, has a button to add to favorites' do
        @item.update(favorite: false)
        visit '/items'
        expect(page).to have_content 'Is Favorite: false'

        click_on 'Add to favorites'
        expect(current_path).to eq '/items'
        expect(page).to have_content 'Is Favorite: true'
      end
    end
  end

  context 'sad path' do
    it 'quantity can not go negative' do
      @item.update(quantity: 0)

      visit '/items'
      expect(page).to have_content 'Amount in stock: 0'

      fill_in :quantity, with: 5
      click_on 'Remove from stock'

      expect(current_path).to eq '/item'
      expect(page).to have_content 'Amount in stock: 0'
      expect(page).to have_content 'Error: this item is out of stock'
    end
  end
end
