namespace :update_completed_fixtures do
	desc "Create appearances, goals and cards for a fixture"
	task setup: :environment do
		league = League.find_by(name: 'Premier League')
		season = league.current_season
		fixtures = season.fixtures_requiring_update.first(30)
		should_wait = fixtures.length > 10

		fixtures.each do |fixture|
			if fixture.home_score.nil?
				ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id }).call
				puts "Fixture #{fixture.id} updated"

				sleep 8 if should_wait
				if fixture.fixture_api_response.finished_fixture
					ApiFootball::Updaters::UpdateFromDbObject.new(fixture: fixture).call
				end
			end
		end

		next_game_week = season.current_game_week + 1
		season.update(current_game_week: next_game_week) if Time.now > season.fixtures_for_current_game_week.last.kick_off + 1.day
	end
end
