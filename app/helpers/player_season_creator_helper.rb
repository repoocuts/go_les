module PlayerSeasonCreatorHelper

  def create_player_season(api_football_id, team_season)
    player = Player.find_by_api_football_id(api_football_id)
    if player.player_seasons.where.not(current_season: true).any? || player.player_seasons.count.zero?
      if player.nil?
        binding.pry
      end
      if player.player_seasons.where(current_season: true).any?
        create_player_season_for_player(player, team_season)
      end
    end
  end

  private

  def create_player_season_for_player(player, team_season)
    PlayerSeason.create(
      player: player,
      team_season: team_season,
      current_season: true
    )
  end
end
