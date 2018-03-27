require 'rails_helper'

RSpec.feature "Users", type: :feature do
  # create
   context "create a new user" do
    before(:each) do
      visit new_user_path
      within('#new_user') do
        # inspect element on page to look for id/name for fill_in xxx
        fill_in "user_name",	with: "Sheng"
      end
    end
    
    scenario "should create user" do
      within('#new_user') do
        fill_in "user_email",	with: "sheng@gmail.com"
        fill_in "user_password",	with: "123456"
        fill_in "user_password_confirmation",	with: "123456" 
      end
      click_button "Create User"
      expect(page).to have_content('Welcome to your profile')
      expect(page).to have_current_path(user_path(User.last))
    end
  end
end
