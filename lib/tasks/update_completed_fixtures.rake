namespace :update_completed_fixtures do
  desc "Create appearances, goals and cards for a fixture"
  task setup: :environment do
    count = 0
    league = League.find_by(name: 'Premier League')
    season = league.current_season
    fixtures = season.completed_fixtures
    fixtures.all.each do |fixture|
	    if fixture.home_score.nil?
        ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id } ).update_fixture
        count = 0
        puts "Fixture #{fixture.id} updated"
	    end
    end
  end
end
