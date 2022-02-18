require 'rails_helper'

RSpec.describe 'login page' do
  let!(:user) { create(:user, name: 'Tim', email: 'tim@email.com', password: '123', password_confirmation: '123') }

  context 'happy path: current user exists' do
    it "logs out the current user and redirects to the landing page" do
      visit "/login"
      fill_in 'email', with: "tim@email.com"
      fill_in 'password', with: "123"
      click_button("Log In")

      visit root_path
      click_button("Log Out")

      expect(current_path).to eq(root_path)
    end
  end
end
