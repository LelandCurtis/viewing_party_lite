require 'rails_helper'

RSpec.describe 'landing page' do
  let!(:user_1) {create(:user, name: "Jeff", email: "jeff@email.com", password: "password", password_confirmation: 'password')}
  let!(:user_2) {create(:user, name: "Amy", email: "amy@email.com")}

  before(:each) do
    visit root_path
  end

  it 'shows the title of the app' do
    expect(page).to have_content("Viewing Party")
  end

  it 'shows a button to create new user' do
    click_link "Create New User"
    expect(current_path).to eq("/register")
  end

  it 'has does n0t show existing user emails if user is not logged in' do
    expect(page).to_not have_content("jeff@email.com")
    expect(page).to_not have_content("amy@email.com")
  end

  it 'has existing user emails if user logged in' do
    visit "/login"
    fill_in 'email', with: user_1.email
    fill_in 'password', with: 'password'
    click_button("Log In")

    visit root_path

    expect(page).to have_content("jeff@email.com")
    expect(page).to have_content("amy@email.com")
  end

  it 'links back to landing page' do
    expect(page).to have_link("Home")
    click_link "Home"
    expect(current_path).to eq(root_path)
  end

  it "links to user login page" do
    expect(page).to have_link "Log In"
    click_link "Log In"
    expect(current_path).to eq("/login")
  end
end
