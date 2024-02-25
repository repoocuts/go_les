# frozen_string_literal: true

class PlayerCombinationsComponent < ViewComponent::Base
	def initialize(team)
		@team = team
	end

	def team_goals
		team.current_team_season.goals
	end

	def combinations_array
		goals_with_assists = team_goals.includes(assist: { player_season: :player }).where.not(assist_id: nil)

		return 'No combinations' if goals_with_assists.empty?

		# Accumulate assist combinations
		assist_combinations = goals_with_assists.each_with_object(Hash.new(0)) do |goal, acc|
			combination_key = [goal.player_season_id, goal.assist&.player_season_id]
			acc[combination_key] += 1
		end

		assist_combinations.sort_by { |_key, value| value }.reverse
	end

	private

	attr_reader :team
end
