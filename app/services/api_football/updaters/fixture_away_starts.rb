module ApiFootball
	module Updaters
		class FixtureAwayStarts

			include AwayStartsCreator
			include PlayerSeasonCreatorHelper

			def update_fixture_away_starts(away_team_api_object, fixture)
				create_away_starts(away_team_api_object, fixture)
			end

			private

			def check_player_objects_exist(api_object, fixture)
				api_object.each do |object|
					player = Player.find_by(api_football_id: object['player']['id'])
					next if player && player.current_player_season.team_season_id == fixture.away_team_season_id

					player = create_new_player(object) if player.nil?
					create_player_season(player, fixture.away_team_season) unless player.current_player_season&.team_season_id == fixture.away_team_season_id
				end
			end

			def create_away_starts(starting_players, fixture)
				check_player_objects_exist(starting_players, fixture)
				create_away_starting_lineup(starting_players, fixture)
			end
		end
	end
end
