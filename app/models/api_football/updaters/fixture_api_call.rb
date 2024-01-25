module ApiFootball
	module Updaters
		class FixtureApiCall

			include ApiFootball
			include CheckPlayerExists

			ENDPOINT = 'fixtures'.freeze
			WIN_POINTS = 3.freeze
			DRAW_POINTS = 3.freeze

			def initialize(fixture:, options:)
				@fixture = fixture
				@options = options || {}
			end

			def update_fixture
				# response = call
				#
				# return if response['response'][0]['lineups'].empty?

				# api_match_object = response['response'][0]
				# ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: {}).update_fixture
				# far = FixtureApiResponse.new
				# far.update(finished_fixture: api_match_object, fixture: fixture)
				api_match_object = FixtureApiResponse.find_by(fixture_id: fixture.id).finished_fixture[0]
				verify_data(api_match_object['lineups'], fixture)

				handle_referee(api_match_object['fixture']['referee'])

				parse_lineups(api_match_object['lineups'], fixture)

				parse_events(api_match_object['events'], fixture)

				update_fulltime_score(api_match_object['score']['fulltime'], fixture)
			end

			private

			attr_reader :fixture, :options

			def interpolate_endpoint
				base_uri + ENDPOINT
			end

			def parse_lineups(lineups, fixture)
				home_team_api_object = lineups[0]['startXI']
				away_team_api_object = lineups[1]['startXI']

				updater_fixture_home_starts(home_team_api_object, fixture)
				updater_fixture_away_starts(away_team_api_object, fixture)
			end

			def parse_events(events, fixture)
				sorted_events = events.sort_by do |obj|
					extra_time = obj['time']['extra']
					elapsed_time = obj['time']['elapsed']
					# If extra_time is nil, it will be sorted as 0, otherwise it will be sorted by its value
					[elapsed_time, extra_time || 0]
				end
				ApiFootball::Updaters::FixtureEvents.new.create_fixture_events(sorted_events, fixture)
			end

			def updater_fixture_home_starts(home_team_api_object, fixture)
				ApiFootball::Updaters::FixtureHomeStarts.new.update_fixture_home_starts(home_team_api_object, fixture)
			end

			def updater_fixture_away_starts(away_team_api_object, fixture)
				ApiFootball::Updaters::FixtureAwayStarts.new.update_fixture_away_starts(away_team_api_object, fixture)
			end

			def update_fulltime_score(scores, fixture)
				fixture.update(home_score: scores['home'], away_score: scores['away'])
				update_team_season_points(scores, fixture.home_team_season, fixture.away_team_season)
			end

			def update_team_season_points(scores, home_team_season, away_team_season)
				home_points = home_team_season.points.nil? ? 0 : home_team_season.points
				away_points = away_team_season.points.nil? ? 0 : away_team_season.points
				if scores['home'].to_i > scores['away'].to_i
					home_team_season.update(points: home_points + WIN_POINTS)
				elsif scores['home'].to_i < scores['away'].to_i
					away_team_season.update(points: away_points + WIN_POINTS)
				else
					home_team_season.update(points: home_points + DRAW_POINTS)
					away_team_season.update(points: away_points + DRAW_POINTS)
				end
			end

			def handle_referee(referee_name)
				referee_name, _country = referee_name.split(',')
				referee = Referee.find_or_create_by(name: referee_name, season_id: fixture.season.id)
				RefereeFixture.create(referee_id: referee.id, fixture_id: fixture.id, season_id: fixture.season.id)
			end
		end
	end
end
