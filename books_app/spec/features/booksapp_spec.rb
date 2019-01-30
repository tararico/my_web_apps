require 'rails_helper'

RSpec.feature "BooksApp", type: :feature do
  let(:user) {FactoryBot.create(:user)}

  scenario "sign in user with nomal login" do
    visit root_path
    click_link "Login", href: new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect {
      expect(page).to have_content "New book"
    }
  end

  describe "with facebook" do
    before do
      OmniAuth.config.mock_auth[:facebook] = nil
      Rails.application.env_config['omniauth.auth'] = facebook_mock
      visit root_path
      click_link "ログイン"
    end
    scenario "sign in" do
      visit root_path
      expect {
        expect(page).to have_content "New book"
      }
    end
  end

  scenario "sign out" do
    visit root_path
    click_link "サインアップ", href: new_user_registration_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign up"
    expect {
      expect(page).to have_content "Welcome! You have signed up successfully."
    }
  end

  scenario " login error" do
    visit root_path
    click_link "Login", href: new_user_session_path
    fill_in "Email", with: user.email
    click_button "Log in"
    expect {
      expect(page).to have_content "Current password can't be blank"
    }
  end

  describe "ログイン中のアクション" do
    before do
      visit root_path
      click_link "Login", href: new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario "create new book" do
      visit root_path
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

    scenario "edit profile" do
      visit root_path
      click_link "Edit profile", href: edit_user_registration_path
      expect {
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Update"
        expect(page).to have_content "Your account has been updated successfully."
      }
    end

    scenario "edit book" do
      FactoryBot.create(:book)
      visit root_path
      click_link "Edit"
      expect {
        fill_in "Title", with: "TestBook"
        fill_in "Memo", with: "Trying out Capybara"
        fill_in "Author", with: "Capybara"
        attach_file 'book image', "#{Rails.root}/spec/factories/book_image.jpg"
        click_button "Update Book"
        expect(page).to have_content "Book was successfully created."
      }
    end

    scenario "destroy book" do
      FactoryBot.create(:book)
      visit root_path
      click_link "Destroy"
      expect {
        expect(page).to have_content "Book was successfully destroyed."
      }
    end
  end
end
