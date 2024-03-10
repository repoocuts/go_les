namespace :update_completed_fixtures do
	desc "Create appearances, goals and cards for a fixture"
	task setup: :environment do
		league = League.find_by(name: 'Premier League')
		season = league.current_season
		fixtures = season.fixtures_for_current_game_week
		should_wait = fixtures.length > 10

		fixtures.all.each do |fixture|
			if fixture.home_score.nil?
				ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id }).call
				puts "Fixture #{fixture.id} updated"

				sleep 8 if should_wait
				ApiFootball::Updaters::UpdateFromDbObject.new(fixture: fixture).call
			end
		end

		next_game_week = season.current_game_week + 1
		season.update(current_game_week: next_game_week) if season.fixtures_for_current_game_week.all? { |fixture| !fixture.home_score.nil? }
	end
end
