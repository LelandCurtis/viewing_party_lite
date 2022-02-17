require 'rails_helper'

RSpec.describe 'new user page' do
  before(:each) do
    visit "/register"
  end

  it 'shows the title of the app' do
    expect(page).to have_content("Viewing Party")
  end

  it 'links back to landing page' do
    expect(page).to have_link("Home")
    click_link "Home"
    expect(current_path).to eq(root_path)
  end

  it 'can create new user and add that user to the session' do
    fill_in 'user[name]', with: "Megan"
    fill_in 'user[email]', with: "megan@email.com"
    fill_in 'user[password]', with: "password"
    fill_in 'user[password_confirmation]', with: "password"
    click_button("Create New User")
    user = User.last

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("#{user.name}'s Dashboard")
    #expect(session[:user_id]).to eq(user.id)
  end

  it 'shows error if user not created' do
    click_button("Create New User")

    expect(current_path).to eq("/register")
    expect(page).to have_content("Name can't be blank, Email can't be blank, and Password can't be blank")
  end

  it 'shows error if passwords do not match' do
    fill_in 'user[name]', with: "Megan"
    fill_in 'user[email]', with: "megan@email.com"
    fill_in 'user[password]', with: "password"
    fill_in 'user[password_confirmation]', with: "passwordabc"

    click_button("Create New User")

    expect(current_path).to eq("/register")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
