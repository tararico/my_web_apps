require 'rails_helper'

RSpec.feature "BooksApp", type: :feature do
  let(:user) {FactoryBot.create(:user)}

  scenario "sign up" do
    visit root_path
    click_link "サインアップ", href: new_user_registration_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign up"
    expect {
      expect(page).to have_content "Welcome! You have signed up successfully."
    }
  end
end
