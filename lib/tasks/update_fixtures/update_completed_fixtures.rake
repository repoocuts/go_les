namespace :update_completed_fixtures do
	desc "Create appearances, goals and cards for a fixture"
	task setup: :environment do
		counter = ApiCallCount.first_or_create(count: 0)
		counter.update(count: 0)

		League.not_hidden.each do |league|
			season = league.current_season
			fixtures = season.completed_fixtures
			puts "Updating #{league.name}"
			count_required = fixtures.count
			puts "Counter count is #{counter.count}"
			if counter.can_make_api_call?(count_required)
				fixtures.each do |fixture|
					if fixture.home_score.nil?
						ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id }).call
						puts "Fixture #{fixture.id} updated"
						counter.increment_count

						sleep 3
						if fixture.fixture_api_response.finished_fixture
							ApiFootball::Updaters::UpdateFromDbObject.new(fixture: fixture).call
						end
					end
				end

				next_game_week = season.current_game_week + 1
				season.update(current_game_week: next_game_week) if Time.now > season.fixtures_for_current_game_week.last.kick_off + 1.day
			end
		end
	end
end
