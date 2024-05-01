module ApiFootball
	module Updaters
		class UpdateFromDbObject < ApplicationService
			include CheckPlayerExists

			WIN_POINTS = 3.freeze
			DRAW_POINTS = 1.freeze

			def initialize(fixture:)
				@fixture = fixture
			end

			def call
				return :fixture_updated if fixture.home_score

				api_match_object = fixture_api_response.finished_fixture

				verify_data(api_match_object['lineups'], fixture)

				handle_referee(api_match_object['fixture']['referee'])

				parse_lineups(api_match_object['lineups'], fixture)

				parse_events(api_match_object['events'], fixture)

				update_corner_kicks(api_match_object['statistics'], fixture)

				update_fulltime_score(api_match_object['score']['fulltime'], fixture)

				head_to_head_updater(fixture)
			end

			private

			attr_reader :fixture

			def fixture_api_response
				fixture.fixture_api_response
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

				ApiFootball::Updaters::FixtureEvents.new(fixture:, events: sorted_events).call
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

			def update_corner_kicks(statistics, fixture)
				corner_objects = statistics.each_with_object({}) do |item, obj|
					team_id = item['team']['id']
					corner_kicks = item['statistics'].find { |stat| stat['type'] == 'Corner Kicks' }&.fetch('value', nil)
					obj[team_id] = corner_kicks
				end
				binding.pry
				fixture.update(home_corners: corner_objects[fixture.home_team_api_football_id], away_corners: corner_objects[fixture.away_team_api_football_id])
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

			def head_to_head_updater(fixture)
				@head_to_head_updater ||= DbUpdater::HeadToHeadUpdater.new(fixture: fixture).call
			end
		end
	end
end
