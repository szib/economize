require 'rails_helper'

RSpec.feature 'User registration', type: :feature do
  scenario 'User register' do
    visit '/signup'

    fill_in 'user_first_name', with: 'Arya'
    fill_in 'user_last_name', with: 'Stark'
    fill_in 'user_email', with: 'arya.stark@winterfell.no'
    fill_in 'user_password', with: '111111'
    fill_in 'user_password_confirmation', with: '111111'
    click_button 'Create User'

    expect(page).to have_text('Welcome, Arya. Have a good time here.')
  end
end
