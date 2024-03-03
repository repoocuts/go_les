module ApiFootball
  module Creators
    class TeamSeasonCreator < ApplicationService

      def initialize(league:, season:)
        @league = league
        @season = season
      end

      def call
        create_current_team_seasons(league: league, season: season)
        create_old_team_seasons(league: league, season: season)
      end

      private

      attr_reader :league, :season
      def create_current_team_seasons(league:, season:)
        Team.where(league_id: league.id).each do |team|
          TeamSeason.create(team_id: team.id, season_id: season.id, current_season: true)
        end
      end

      def create_old_team_seasons(league:, season:)
        Team.where(league_id: league.id).each do |team|
          TeamSeason.create(team_id: team.id, season_id: season.id, current_season: false)
        end
      end
    end
  end
end
