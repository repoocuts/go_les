module ApiFootball
	module Updaters
		class FixtureEvents

			include GoalCreatorHelper
			include CardCreatorHelper
			include SubCreatorHelper

			def create_fixture_events(events, fixture)
				substitute_events, non_sub_events = events.partition { |event| event['type'] == 'subst' }
				substitute_events.each do |event|
					team_season_for_event = return_team_season_from_api_football_id(fixture, event['team']['id'])
					create_substitute_from_api_data(event, fixture, team_season_for_event)
				end
				non_sub_events.each do |event|
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
