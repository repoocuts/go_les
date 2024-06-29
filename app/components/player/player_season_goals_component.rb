# frozen_string_literal: true

class Player::PlayerSeasonGoalsComponent < ViewComponent::Base

	def initialize(player_season:)
		@player_season = player_season
	end

	def average_minutes_per_goal
		player_season.average_minutes_per_goal
	end

	def average_minutes_per_home_goal
		player_season.average_minutes_per_home_goal
	end

	def average_minutes_per_away_goal
		player_season.average_minutes_per_away_goal
	end

	def home_goals
		player_season.home_goals_count
	end

	def away_goals
		player_season.away_goals_count
	end

	def first_half_goals
		player_season.first_half_goals_count
	end

	def second_half_goals
		player_season.second_half_goals_count
	end

	def first_half_home_goals
		player_season.first_half_home_goals_count
	end

	def first_half_away_goals
		player_season.first_half_away_goals_count
	end

	def second_half_home_goals
		player_season.second_half_home_goals_count
	end

	def second_half_away_goals
		player_season.second_half_away_goals_count
	end

	private

	attr_reader :player_season
end
