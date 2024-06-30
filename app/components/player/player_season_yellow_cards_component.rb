# frozen_string_literal: true

class Player::PlayerSeasonYellowCardsComponent < ViewComponent::Base

	def initialize(player_season:)
		@player_season = player_season
	end

	def home_yellow_cards
		player_season.season_home_yellows_count
	end

	def away_yellow_cards
		player_season.season_away_yellows_count
	end

	def first_half_home_yellow_cards_count
		player_season.first_half_home_yellow_cards_count
	end

	def first_half_away_yellow_cards_count
		player_season.first_half_away_yellow_cards_count
	end

	def second_half_home_yellow_cards_count
		player_season.second_half_home_yellow_cards_count
	end

	def second_half_away_yellow_cards_count
		player_season.second_half_away_yellow_cards_count
	end

	def average_minutes_per_home_yellow_card
		player_season.average_minutes_per_home_yellow_card
	end

	def average_minutes_per_away_yellow_card
		player_season.average_minutes_per_away_yellow_card
	end

	private

	attr_reader :player_season
end
