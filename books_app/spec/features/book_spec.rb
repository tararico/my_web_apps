require 'rails_helper'

RSpec.feature "BooksApp", type: :feature do
  let(:user) {FactoryBot.create(:user)}

  describe "create and destroy books" do
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
