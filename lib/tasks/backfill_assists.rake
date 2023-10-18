namespace :backfill_assists do
	desc "backfill assists for completed fixtures"
	task setup: :environment do
		league = League.find_by(name: 'Premier League')
		season = league.current_season
		fixtures = season.fixtures.where('kick_off < ? AND (SELECT COUNT(*) FROM appearances WHERE appearances.fixture_id = fixtures.id) > ?', 12.hours.ago, 0)

		fixtures.all.each do |fixture|
			unless fixture.home_score.nil?
				response = ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id }).call
				api_match_object = response['response'][0]
				events = api_match_object['events']
				events.each do |event|
					if event['type'] == 'Goal' && event['assist']['id'].present?
						scorer_appearance = fixture.appearances.find_by(player_season: Player.find_by_api_football_id(event['player']['id']))
						assist_appearance = fixture.appearances.find_by(player_season: Player.find_by_api_football_id(event['assist']['id']))
						goal = fixture.goals.find_by(appearance: scorer_appearance, minute: event['time']['elapsed'])
						assist = Assist.create(goal: goal, appearance: assist_appearance, fixture: fixture, team_season: goal.team_season,
						                       player_season: assist_appearance.player_season, minute: event['time']['elapsed'], is_home: goal.is_home)
						puts "Goal #{goal.id} now has assist #{assist.id}"
					end
				end
			end

			sleep 4
		end
	end
end
