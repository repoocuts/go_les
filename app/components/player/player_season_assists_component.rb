# frozen_string_literal: true

class Player::PlayerSeasonAssistsComponent < ViewComponent::Base

	def initialize(player_season:)
		@player_season = player_season
	end

	def average_minutes_per_assist
		player_season.average_minutes_per_assist
	end

	def average_minutes_per_home_assist
		player_season.average_minutes_per_home_assist
	end

	def average_minutes_per_away_assist
		player_season.average_minutes_per_away_assist
	end

	def home_assists
		player_season.home_assists_count
	end

	def away_assists
		player_season.away_assists_count
	end

	def first_half_assists
		player_season.first_half_assists_count
	end

	def second_half_assists
		player_season.second_half_assists_count
	end

	def first_half_home_assists
		player_season.first_half_home_assists_count
	end

	def first_half_away_assists
		player_season.first_half_away_assists_count
	end

	def second_half_home_assists
		player_season.second_half_home_assists_count
	end

	def second_half_away_assists
		player_season.second_half_away_assists_count
	end

	private

	attr_reader :player_season
end
