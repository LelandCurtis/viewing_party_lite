require 'rails_helper'

RSpec.describe 'login page' do
  let!(:user) { create(:user, name: 'Tim', email: 'tim@email.com', password: '123', password_confirmation: '123') }
  context 'happy path: correct info' do
    it "has a form that allows the user to login and get redirected to their user show page" do
      visit "/login"

      fill_in 'email', with: "tim@email.com"
      fill_in 'password', with: "123"
      click_button("Log In")

      expect(current_path).to eq('/dashboard')
    end
  end

  context 'sad path: bad info' do
    it "redirects back to login page if info is blank" do
      visit "/login"

      click_button("Log In")

      expect(current_path).to eq("/login")
      expect(page).to have_content("Email not found")
    end

    it "redirects back to login page if email is not in system" do
      visit "/login"

      fill_in 'email', with: "tim23423525@email.com"
      fill_in 'password', with: "123"
      click_button("Log In")

      expect(current_path).to eq("/login")
      expect(page).to have_content("Email not found")
    end

    it "redirects back to login page if passwords do not match" do
      visit "/login"

      fill_in 'email', with: "tim@email.com"
      fill_in 'password', with: "password123"
      click_button("Log In")

      expect(current_path).to eq("/login")
      expect(page).to have_content("Incorrect Password")
    end
  end
end
