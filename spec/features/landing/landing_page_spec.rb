require 'rails_helper'

RSpec.describe 'The Landing Page' do
  it 'should have Hello World' do
    visit '/'
    expect(page).to have_content 'Hello World'
  end
end
