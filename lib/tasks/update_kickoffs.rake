namespace :update_kickoffs do
	desc "Create appearances, goals and cards for a fixture"
	task setup: :environment do
		count = 0
		season = Season.current_season
		fixtures = season.fixtures_for_next_game_week
		fixtures.all.each do |fixture|
			response = ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id }).call
			response_kick_off = response['response'][0]['fixture']['date']
			fixture.update(kick_off: response_kick_off) if fixture.kick_off != response_kick_off
			puts "Fixture #{fixture.id} updated"
			count += 1
		end
	end
end
