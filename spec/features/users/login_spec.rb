require 'rails_helper'

RSpec.describe 'login page' do
  let!(:user) { create(:user, name: 'Tim', email: 'tim@email.com', password: '123', password_confirmation: '123') }
  context 'happy path: correct info' do
    it "has a form that allows the user to login and get redirected to their user show page" do
      visit "/users/login"

      fill_in 'user[name]', with: "Megan"
      fill_in 'user[email]', with: "megan@email.com"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password"
      click_button("Log In")

      expect(current_path).to eq(user_path(user))
    end
  end

  context 'sad path: bad info' do
    it "redirects back to login page if info is incorrect" do
      visit "/users/login"

      fill_in 'user[name]', with: "Megan"
      fill_in 'user[email]', with: "megan@email.com"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password123"
      click_button("Log In")

      expect(current_path).to eq("/users/login")
      expect(page).to have_content("Name can't be blank, Email can't be blank, and Password can't be blank")
    end

    it "redirects back to login page if ipasswords do not match" do
      visit "/users/login"

      fill_in 'user[name]', with: "Megan"
      fill_in 'user[email]', with: "megan@email.com"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password123"
      click_button("Log In")

      expect(current_path).to eq("/users/login")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
