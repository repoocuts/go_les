module ApiFootball
  module Creators
    class TeamSeasonCreator
      def create_current_team_seasons(league:, season:)
        Team.where(league_id: league.id).each do |team|
          team_season = TeamSeason.create(team_id: team.id, season_id: season.id, current_season: true)
        end
      end

      def create_old_team_seasons(league:, season:)
        Team.where(league_id: league.id).each do |team|
          team_season = TeamSeason.create(team_id: team.id, season_id: season.id, current_season: false)
        end
      end
    end
  end
end
