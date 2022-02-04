require 'rails_helper'

RSpec.describe 'new viewing party page' do
  let!(:user) {User.create(name: "Jeff", email: "jeff@email.com")}

  it "exists" do
    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/users/#{user.id}/movies/#{movie.id}/viewing-party/new"

      expect(page).to have_content("Dune")
    end
  end

  it "has a form with a duration of party field that has a default value set to the movie length" do
    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/users/#{user.id}/movies/#{movie.id}/viewing-party/new"

      expect(page).to have_field('Duration of Party', with: 155)
      fill_in 'Duration of Party', with: "300"
    end
  end

  it "has a form with a date and time field" do
    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/users/#{user.id}/movies/#{movie.id}/viewing-party/new"


      fill_in 'Date', with: "02/03/2022"
      fill_in 'Start Time', with: "06:30"

      expect(page).to have_field('Date', with: "02/03/2022")
      expect(page).to have_field('Start Time', with: "06:30")
    end
  end

  it "has checkboxes for each user in the system" do
    user_1 = create(:user, name: 'Abby')
    user_2 = create(:user, name: 'Bob')
    user_3 = create(:user, name: 'Christy')
    user_4 = create(:user, name: 'Dave')

    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/users/#{user.id}/movies/#{movie.id}/viewing-party/new"


      within 'div.users' do
        expect(page).to have_content('Abby')
        expect(page).to have_content('Bob')
        expect(page).to have_content('Christy')
        expect(page).to have_content('Dave')
        expect(page).to_not have_content('Jeff')
      end
    end
  end
end
