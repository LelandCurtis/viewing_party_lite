require 'rails_helper'

RSpec.describe 'the user discover page' do
  let!(:user) { create(:user, name: 'Tim', email: 'tim@email.com', password: '123', password_confirmation: '123') }

  before(:each) do
    visit "/login"
    fill_in 'email', with: "tim@email.com"
    fill_in 'password', with: "123"
    click_button("Log In")
  end

  it "has a form to search by movie title that redirects you to a results page" do
    visit "/discover"

    VCR.use_cassette('Fight_Club_search') do
      fill_in :q, with: 'Fight Club'
      click_button 'Search'

      expect(current_path).to eq("/movies")
    end
  end

  it "has a button to search for top rated movies that redirects you to a results page" do
    visit "/discover"

    VCR.use_cassette('top_rated_search') do
      click_button 'Discover Top Rated Movies'

      expect(current_path).to eq("/movies")
    end
  end
end
