module ApiFootball
	module Updaters
		class FixtureHomeStarts

			include HomeStartsCreator
			include PlayerSeasonCreatorHelper

			def update_fixture_home_starts(home_team_api_object, fixture)
				create_home_starts(home_team_api_object, fixture)
			end

			private

			def check_player_objects_exist(api_object, fixture)
				api_object.each do |object|
					player = Player.find_by(api_football_id: object['player']['id'])
					next if player && player.current_player_season.team_season_id == fixture.home_team_season_id

					player = create_new_player(object) if player.nil?
					create_player_season(player, fixture.home_team_season) unless player.current_player_season&.team_season_id == fixture.home_team_season_id
				end
			end

			def create_home_starts(starting_players, fixture)
				check_player_objects_exist(starting_players, fixture)
				create_home_starting_lineup(starting_players, fixture)
			end

			def create_new_player(api_data)
				Player.create(short_name: api_data['player']['name'], api_football_id: api_data['player']['id'], position: api_data['player']['pos'], team_id: fixture.home_team_object.id)
			end
		end
	end
end
