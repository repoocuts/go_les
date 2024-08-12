# frozen_string_literal: true

class LeagueTableComponent < ViewComponent::Base
	include ApplicationHelper

	def initialize(team_seasons)
		@team_seasons = team_seasons
	end

	def league_table_order
		team_seasons.includes(:team, :goals_scored_stat, :goals_conceded_stat, :yellow_cards_stat, :red_cards_stat).order(:points).reverse
	end

	def team_name
		team_season.name
	end

	def team_season_id
		team_season.id
	end

	def team_season_completed_fixtures_count
		team_season.completed_fixtures_count
	end

	def team_season_goals_count
		team_season.goals_count
	end

	def goals_against_number
		team_season.goals_against_number
	end

	def team_season_goal_difference
		team_season.goal_difference
	end

	def team_season_yellow_card_count
		team_season.yellow_card_count
	end

	def team_season_red_card_count
		team_season.red_card_count
	end

	def team_season_points
		team_season.points
	end

	private

	attr_reader :team_seasons
end
