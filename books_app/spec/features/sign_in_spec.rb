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

  scenario " login error" do
    visit root_path
    click_link "Login", href: new_user_session_path
    fill_in "Email", with: user.email
    click_button "Log in"
    expect {
      expect(page).to have_content "Current password can't be blank"
    }
  end

  describe "if you login" do
    before do
      visit root_path
      click_link "Login", href: new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
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

    scenario "logout" do
      visit root_path
      click_link "Logout"
      expect {
        expect(page).to have_content "You need to sign in or sign up before continuing."
      }
    end
  end
end
