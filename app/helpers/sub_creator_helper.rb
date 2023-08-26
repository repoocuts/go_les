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
    player_out_start = fixture.appearances.where(player_season: player_out_player_season).first
    if player_out_player_season.nil? || player_in_player_season.nil? || player_out_start.nil?
      #Fixture 13 is where to get this fixed
      binding.pry
      create_player_season(event['assist']['id'], team_season) if event['assist']['id']
      create_player_season(event['player']['id'], team_season) if event['player']['id']
    end
    Appearance.create(
      fixture_id: fixture.id,
      is_home: true,
      minutes: 90 - event['time']['elapsed'],
      player_season_id: player_in_player_season.id,
      team_season_id: team_season.id,
      appearance_type: 'substitute'
    )
    player_out_start.update(minutes: event['time']['elapsed'])
  end

  def substitute_for_away(event, fixture, team_season)
    player_out_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
    player_in_player_season = Player.find_by_api_football_id(event['assist']['id']).current_player_season
    player_out_start = fixture.appearances.where(player_season: player_out_player_season).first
    if player_out_player_season.nil? || player_in_player_season.nil? || player_out_start.nil?
      binding.pry
      create_player_season(event['assist']['id'], team_season) if event['assist']['id']
      create_player_season(event['player']['id'], team_season) if event['player']['id']
    end
    Appearance.create(
      fixture_id: fixture.id,
      minutes: 90 - event['time']['elapsed'],
      player_season_id: player_in_player_season.id,
      team_season_id: team_season.id,
      appearance_type: 'substitute'
    )
    player_out_start.update(minutes: event['time']['elapsed'])
  end

  def create_player_season(api_football_id, team_season)
    player = Player.find_by_api_football_id(api_football_id)
    if player.player_seasons.where.not(current_season: true).any? || player.player_seasons.count.zero?
      if player.nil?
        binding.pry
      end
      if player.player_seasons.where.not(current_season: true).any? || player.player_seasons.count.zero?
        create_player_season_for_player(player, team_season)
      end
    end
  end

  def create_player_season_for_player(player, team_season)
    PlayerSeason.create(
      player: player,
      team_season: team_season,
      current_season: true,
      season: team_season.season
    )
  end
end
