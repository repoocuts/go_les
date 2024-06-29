# frozen_string_literal: true

class Player::PlayerSeasonYellowCardsComponent < ViewComponent::Base

	def initialize(player_season:)
		@player_season = player_season
	end

	private

	attr_reader :player_season
end
