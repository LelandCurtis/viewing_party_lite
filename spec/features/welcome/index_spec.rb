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

  it 'has links to existing user dashboards' do
    expect(page).to have_link("jeff@email.com")
    expect(page).to have_link("amy@email.com")

  end

  it "has links that redirect to login page if user has not logged in" do
    click_link "jeff@email.com"
    expect(current_path).to eq("/login")
  end

  it "has links that redirect to user dashboard page if that user has logged in" do
    visit "/login"
    fill_in 'email', with: user_1.email
    fill_in 'password', with: 'password'
    click_button("Log In")

    visit root_path

    click_link "jeff@email.com"
    expect(current_path).to eq("/dashboard")
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
