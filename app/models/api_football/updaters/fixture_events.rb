module ApiFootball
	module Updaters
		class FixtureEvents

			include GoalCreatorHelper
			include CardCreatorHelper
			include SubCreatorHelper

			def create_fixture_events(events, fixture)
				events.each do |event|
					next if event['player']['id'] == 19657
					team_season_for_event = return_team_season_from_api_football_id(fixture, event['team']['id'])
					case event['type']
					when 'Goal'
						create_goal_from_api_data(event, fixture, team_season_for_event)
					when 'Card'
						if event['detail'] == 'Yellow Card'
							create_yellow_from_api_data(event, fixture, team_season_for_event)
						end
						if event['detail'] == 'Red Card'
							create_red_from_api_data(event, fixture, team_season_for_event)
						end
					when 'subst'
						create_substitute_from_api_data(event, fixture, team_season_for_event)
					end
				end
			end

			private

			def return_team_season_from_api_football_id(fixture, api_football_team_id)
				fixture.home_team_api_football_id == api_football_team_id ? fixture.home_team_season : fixture.away_team_season
			end
		end
	end
end
