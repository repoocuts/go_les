module SubCreatorHelper

	def create_substitute_from_api_data(event, fixture, team_season)
		case fixture.home_team_season == team_season
		when true
			substitute_for_home(event, fixture, team_season)
		else
			substitute_for_away(event, fixture, team_season)
		end
	end

	private

	def substitute_for_home(event, fixture, team_season)
		player_out_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
		player_in_player_season = Player.find_by_api_football_id(event['assist']['id']).current_player_season
		player_out_start = fixture.appearances.find_by(player_season: player_out_player_season)
		if player_out_player_season.nil? || player_in_player_season.nil? || player_out_start.nil?
			# Fixture 13 is where to get this fixed
			puts "Fixture #{fixture.id} substitute_for_home in sub creator helper"
			ObjectHandlingFailure.create(object_type: 'player_season', api_response_element: event, related_team_id: team_season.id, related_fixture_id: fixture.id)
		end
		Appearance.create(
			fixture_id: fixture.id,
			is_home: true,
			minutes: 90 - event['time']['elapsed'],
			player_season_id: player_in_player_season.id,
			team_season_id: team_season.id,
			appearance_type: 'substitute'
		)
		player_out_start.update(minutes: event['time']['elapsed']) if player_out_start
	end

	def substitute_for_away(event, fixture, team_season)
		player_out_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
		player_in_player_season = Player.find_by_api_football_id(event['assist']['id']).current_player_season
		player_out_start = fixture.appearances.find_by(player_season: player_out_player_season)
		if player_out_player_season.nil? || player_in_player_season.nil? || player_out_start.nil?
			puts "Fixture #{fixture.id} substitute_for_away in sub creator helper"
			ObjectHandlingFailure.create(object_type: 'player_season', api_response_element: event, related_team_id: team_season.id, related_fixture_id: fixture.id)
		end
		Appearance.create(
			fixture_id: fixture.id,
			minutes: 90 - event['time']['elapsed'],
			player_season_id: player_in_player_season.id,
			team_season_id: team_season.id,
			appearance_type: 'substitute'
		)
		player_out_start.update(minutes: event['time']['elapsed']) if player_out_start
	end
end
