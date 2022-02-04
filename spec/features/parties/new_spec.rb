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
    end
  end
end
