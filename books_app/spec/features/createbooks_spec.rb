require 'rails_helper'

RSpec.feature "Create books", type: :feature do
  scenario "sign in user with nomal login and create books" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "Login", href: new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_link "New Book"

    expect {
      fill_in "Title", with: "TestBook"
      fill_in "Memo", with: "Trying out Capybara"
      fill_in "Author", with: "Capybara"
      attach_file 'book image', "#{Rails.root}/spec/factories/book_image.jpg"
      click_button "New Book"
      expect(page).to have_content "Book was successfully created."
    }
  end

  describe "login with facebook" do
    before do
      OmniAuth.config.mock_auth[:facebook] = nil
      Rails.application.env_config['omniauth.auth'] = facebook_mock
      visit root_path
      click_link "ログイン"
    end

    scenario "create books" do
      visit root_path
      click_link "New Book"

      expect{
        fill_in "Title", with: "TestBook"
        fill_in "Memo", with: "Trying out Capybara"
        fill_in "Author", with: "Capybara"
        attach_file 'book image', "#{Rails.root}/spec/factories/book_image.jpg"
        click_button "New Book"
        expect(page).to have_content "Book was successfully created."
      }
      end
  end
end
