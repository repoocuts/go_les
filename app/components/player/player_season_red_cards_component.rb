# frozen_string_literal: true

class Player::PlayerSeasonRedCardsComponent < ViewComponent::Base

	def initialize(player_season:)
		@player_season = player_season
	end

	def initialize(player_season:)
		@player_season = player_season
	end

	def home_red_cards
		player_season.season_home_reds_count
	end

	def away_red_cards
		player_season.season_away_reds_count
	end

	def first_half_home_red_cards_count
		player_season.first_half_home_red_cards_count
	end

	def first_half_away_red_cards_count
		player_season.first_half_away_red_cards_count
	end

	def second_half_home_red_cards_count
		player_season.second_half_home_red_cards_count
	end

	def second_half_away_red_cards_count
		player_season.second_half_away_red_cards_count
	end

	def average_minutes_per_home_red_card
		player_season.average_minutes_per_home_red_card
	end

	def average_minutes_per_away_red_card
		player_season.average_minutes_per_away_red_card
	end

	private

	attr_reader :player_season
end
