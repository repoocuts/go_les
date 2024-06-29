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

	private

	attr_reader :player_season
end
