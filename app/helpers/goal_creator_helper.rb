module GoalCreatorHelper
  
  def create_goal_from_api_data(event, fixture, team_season)
    case fixture.home_team_season == team_season
    when true
      event['detail'] == 'Own Goal' ? own_goal_for_home(event, fixture, team_season) : goal_for_home(event, fixture, team_season)
    else
      event['detail'] == 'Own Goal' ? own_goal_for_away(event, fixture, team_season) : goal_for_away(event, fixture, team_season)
    end
  end

  private

  def goal_for_home(event, fixture, team_season)
    scorer_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    home_start = fixture.appearances.where(player_season: scorer_player_season).first
    Goal.create(
      fixture_id: fixture.id,
      appearance_id: home_start.id,
      goal_type: event['type'].downcase,
      is_home: true,
      minute: event['time']['elapsed'],
      player_season_id: scorer_player_season.id,
      team_season_id: team_season.id
    )
  end

  def goal_for_away(event, fixture, team_season)
    scorer_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    away_start = fixture.appearances.where(player_season: scorer_player_season).first
    Goal.create(
      appearance_id: away_start.id,
      goal_type: event['type'].downcase,
      fixture_id: fixture.id,
      minute: event['time']['elapsed'],
      player_season_id: scorer_player_season.id,
      team_season_id: team_season.id,
    )
  end

  def own_goal_for_home(event, fixture, team_season)
    scorer_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    away_start = fixture.appearances.where(player_season: scorer_player_season).first
    Goal.create(
      appearance_id: away_start.id,
      fixture_id: fixture.id,
      minute: event['time']['elapsed'],
      own_goal: true,
      player_season_id: scorer_player_season.id,
      team_season_id: team_season.id,
    )
  end

  def own_goal_for_away(event, fixture, team_season)
    scorer_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    home_start = fixture.appearances.where(player_season: scorer_player_season).first
    Goal.create(
      fixture_id: fixture.id,
      appearance_id: home_start.id,
      minute: event['time']['elapsed'],
      own_goal: true,
      player_season_id: scorer_player_season.id,
      team_season_id: team_season.id,
    )
  end
end
