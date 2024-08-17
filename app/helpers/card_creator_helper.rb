module CardCreatorHelper

	def create_yellow_from_api_data(event, fixture, team_season)
		case fixture.home_team_season == team_season
		when true
			yellow_card_for_home(event, fixture, team_season)
		else
			yellow_card_for_away(event, fixture, team_season)
		end
	end

	def create_red_from_api_data(event, fixture, team_season)
		case fixture.home_team_season == team_season
		when true
			red_card_for_home(event, fixture, team_season)
		else
			red_card_for_away(event, fixture, team_season)
		end
	end

	private

	def yellow_card_for_home(event, fixture, team_season)
		booked_player_season = Player.find_by_api_football_id(event['player']['id'])&.current_player_season

		object_handling_failure(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id) unless booked_player_season

		home_start = fixture.appearances.find_by(player_season: booked_player_season)
		if booked_player_season && home_start
			card = Card.create(
				card_type: 'yellow',
				fixture_id: fixture.id,
				appearance_id: home_start.id,
				is_home: true,
				minute: event['time']['elapsed'],
				player_season_id: booked_player_season.id,
				team_season_id: team_season.id,
				referee_fixture_id: fixture.referee_fixture.id,
			)

			update_player_season_defensive_stat_yellow_card(booked_player_season.discipline_stat, card)
		else
			ObjectHandlingFailure.create(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
		end
	end

	def yellow_card_for_away(event, fixture, team_season)
		booked_player_season = Player.find_by_api_football_id(event['player']['id'])&.current_player_season

		object_handling_failure(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id) unless booked_player_season

		away_start = fixture.appearances.find_by(player_season: booked_player_season)
		if booked_player_season && away_start
			card = Card.create(
				appearance_id: away_start.id,
				card_type: 'yellow',
				fixture_id: fixture.id,
				minute: event['time']['elapsed'],
				player_season_id: booked_player_season.id,
				team_season_id: team_season.id,
				referee_fixture_id: fixture.referee_fixture.id,
			)

			update_player_season_defensive_stat_yellow_card(booked_player_season.discipline_stat, card)
		else
			object_handling_failure(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
		end
	end

	def red_card_for_home(event, fixture, team_season)
		booked_player_season = Player.find_by_api_football_id(event['player']['id'])&.current_player_season

		object_handling_failure(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)

		home_start = fixture.appearances.find_by(player_season: booked_player_season)
		if booked_player_season && home_start
			card = Card.create(
				card_type: 'red',
				fixture_id: fixture.id,
				appearance_id: home_start.id,
				is_home: true,
				minute: event['time']['elapsed'],
				player_season_id: booked_player_season.id,
				team_season_id: team_season.id,
				referee_fixture_id: fixture.referee_fixture.id,
			)

			update_player_season_defensive_stat_red_card(booked_player_season.discipline_stat, card)
		else
			object_handling_failure(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
		end
	end

	def red_card_for_away(event, fixture, team_season)
		booked_player_season = Player.find_by_api_football_id(event['player']['id'])&.current_player_season

		object_handling_failure(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id) unless booked_player_season

		away_start = fixture.appearances.find_by(player_season: booked_player_season)
		if booked_player_season && away_start
			card = Card.create(
				appearance_id: away_start.id,
				card_type: 'red',
				fixture_id: fixture.id,
				minute: event['time']['elapsed'],
				player_season_id: booked_player_season.id,
				team_season_id: team_season.id,
				referee_fixture_id: fixture.referee_fixture.id,
			)

			update_player_season_defensive_stat_red_card(booked_player_season.discipline_stat, card)
		else
			object_handling_failure(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
		end
	end

	def update_player_season_defensive_stat_yellow_card(discipline_stat, card)
		discipline_stat.increment(:yellow_card_total)
		if card.is_home
			discipline_stat.increment(:yellow_card_home)
			if card.minute < 45
				discipline_stat.increment(:yellow_card_first_half)
				discipline_stat.increment(:yellow_card_home_first_half)
			else
				discipline_stat.increment(:yellow_card_second_half)
				discipline_stat.increment(:yellow_card_home_second_half)
			end
		else
			discipline_stat.increment(:yellow_card_away)
			if card.minute < 45
				discipline_stat.increment(:yellow_card_second_half)
				discipline_stat.increment(:yellow_card_away_second_half)
			else
				discipline_stat.increment(:yellow_card_first_half)
				discipline_stat.increment(:yellow_card_away_first_half)
			end
		end
		discipline_stat.save
	end

	def update_player_season_defensive_stat_red_card(discipline_stat, card)
		discipline_stat.increment(:red_card_total)
		if card.is_home
			discipline_stat.increment(:red_card_home)
			if card.minute < 45
				discipline_stat.increment(:red_card_first_half)
				discipline_stat.increment(:red_card_home_first_half)
			else
				discipline_stat.increment(:red_card_second_half)
				discipline_stat.increment(:red_card_home_second_half)
			end
		else
			discipline_stat.increment(:red_card_away)
			if card.minute < 45
				discipline_stat.increment(:red_card_second_half)
				discipline_stat.increment(:red_card_away_second_half)
			else
				discipline_stat.increment(:red_card_first_half)
				discipline_stat.increment(:red_card_away_first_half)
			end
		end
		discipline_stat.save
	end

	def object_handling_failure(object_type:, api_response_element:, related_team_season_id:, related_fixture_id:)
		ObjectHandlingFailure.create(object_type:, api_response_element:, related_team_season_id:, related_fixture_id:)
	end
end
