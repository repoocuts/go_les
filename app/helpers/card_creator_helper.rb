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
    booked_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    home_start = fixture.appearances.where(player_season: booked_player_season).first
    if booked_player_season && home_start
      Card.create(
        card_type: 'yellow',
        fixture_id: fixture.id,
        appearance_id: home_start.id,
        is_home: true,
        minute: event['time']['elapsed'],
        player_season_id: booked_player_season.id,
        team_season_id: team_season.id,
        referee_fixture_id: fixture.referee_fixture.id,
      )
    else
      ObjectHandlingFailure.create(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
    end
  end

  def yellow_card_for_away(event, fixture, team_season)
    booked_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    away_start = fixture.appearances.where(player_season: booked_player_season).first
    if booked_player_season && away_start
      Card.create(
        appearance_id: away_start.id,
        card_type: 'yellow',
        fixture_id: fixture.id,
        minute: event['time']['elapsed'],
        player_season_id: booked_player_season.id,
        team_season_id: team_season.id,
        referee_fixture_id: fixture.referee_fixture.id,
      )
    else
      ObjectHandlingFailure.create(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
    end
  end

  def red_card_for_home(event, fixture, team_season)
    booked_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    home_start = fixture.appearances.where(player_season: booked_player_season).first
    if booked_player_season && home_start
      Card.create(
        card_type: 'red',
        fixture_id: fixture.id,
        appearance_id: home_start.id,
        is_home: true,
        minute: event['time']['elapsed'],
        player_season_id: booked_player_season.id,
        team_season_id: team_season.id,
        referee_fixture_id: fixture.referee_fixture.id,
      )
    else
      ObjectHandlingFailure.create(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
    end
  end

  def red_card_for_away(event, fixture, team_season)
    booked_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    away_start = fixture.appearances.where(player_season: booked_player_season).first
    if booked_player_season && away_start
      Card.create(
        appearance_id: away_start.id,
        card_type: 'red',
        fixture_id: fixture.id,
        minute: event['time']['elapsed'],
        player_season_id: booked_player_season.id,
        team_season_id: team_season.id,
        referee_fixture_id: fixture.referee_fixture.id,
      )
    else
      ObjectHandlingFailure.create(object_type: 'card', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
    end
  end
end
