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
          team_season = TeamSeason.create(team_id: team.id, season_id: season.id, current_season: true)
          create_association_objects(team_season)
          create_head_to_heads_for_team(team, team_season, league)
        end
      end

      def create_old_team_seasons(league:, season:)
        Team.where(league_id: league.id).each do |team|
          TeamSeason.create(team_id: team.id, season_id: season.id, current_season: false)
        end
      end

      def create_association_objects(team_season)
        create_goals_conceded_stat(team_season)
        create_goals_scored_stat(team_season)
        create_red_cards_stat(team_season)
        create_yellow_cards_stat(team_season)
      end

      def create_goals_conceded_stat(team_season)
        GoalsConcededStat.create(team_season_id: team_season.id)
      end

      def create_goals_scored_stat(team_season)
        GoalsScoredStat.create(team_season_id: team_season.id)
      end

      def create_red_cards_stat(team_season)
        RedCardsStat.create(team_season_id: team_season.id)
      end

      def create_yellow_cards_stat(team_season)
        YellowCardsStat.create(team_season_id: team_season.id)
      end

      def create_head_to_heads_for_team(team, team_season, league)
        league.teams.where.not(id: team.id).each do |other_team|
          HeadToHead.create(team_id: team.id, opponent_id: other_team.id, current_team_season_id: team_season.id) unless HeadToHead.exists?(team_id: team.id, opponent_id: other_team.id)
        end
      end
  end
end
