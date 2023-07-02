class Creators::TeamSeasonCreator

  def create_team_seasons
    current_seasons = Season.where(current_season: true)
    current_seasons.each do |season|
      league = League.find(season.league_id)
      Team.where(league_id: league.id).each do |team|
        team_season = TeamSeason.create(team_id: team.id, season_id: season.id, current_season: true)
      end
    end
  end

end