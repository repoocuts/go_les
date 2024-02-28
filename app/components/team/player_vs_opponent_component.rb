# frozen_string_literal: true

class Team::PlayerVsOpponentComponent < ViewComponent::Base
	def initialize(current_team_season, next_match, next_opponent)
		@current_team_season = current_team_season
		@next_match = next_match
		@next_opponent = next_opponent
	end

	def top_scorer_against_opponent
		scorer = current_team_season.goals.where(team_season_id: next_opponent.id).group_by(&:player_season_id).max_by { |_k, v| v.size }

		return 'No Scorer' if scorer.nil?

		PlayerSeason.find(scorer[0]).get_player_name
	end

	def top_scorer_against
		scorer = goals_against.group_by(&:player_season_id).max_by { |_k, v| v.size }

		return 'No Scorer' if scorer.nil?

		"#{PlayerSeason.find(scorer[0]).get_player_name}, (#{scorer[1].size})"
	end

	def most_booked_against_opponent
		booked_player = current_team_season.yellow_cards.where(team_season_id: next_opponent.id).group_by(&:player_season_id).max_by { |_k, v| v.size }

		return 'No Bookings' if booked_player.nil?

		PlayerSeason.find(booked_player[0]).get_player_name
	end

	def most_booked_against
		booked_player = yellow_cards_against.group_by(&:player_season_id).max_by { |_k, v| v.size }

		return 'No Bookings' if booked_player.nil?

		"#{PlayerSeason.find(booked_player[0]).get_player_name}, (#{booked_player[1].size})"
	end

	def most_reds_against_opponent
		reds_player = current_team_season.red_cards.where(team_season_id: next_opponent.id).group_by(&:player_season_id).max_by { |_k, v| v.size }

		return 'No Reds' if reds_player.nil?

		PlayerSeason.find(reds_player[0]).get_player_name
	end

	def most_reds_against
		reds_player = red_cards_against.group_by(&:player_season_id).max_by { |_k, v| v.size }

		return 'No Reds' if reds_player.nil?

		"#{PlayerSeason.find(reds_player[0]).get_player_name}, (#{reds_player[1].size})"
	end

	def most_assists_against_opponent
		assists_player = current_team_season.assists.where(team_season_id: next_opponent.id).group_by(&:player_season_id).max_by { |_k, v| v.size }

		return 'No Assists' if assists_player.nil?

		PlayerSeason.find(assists_player[0]).get_player_name
	end

	def most_assists_against
		assists_player = assists_against.group_by(&:player_season_id).max_by { |_k, v| v.size }

		return 'No Assists' if assists_player.nil?

		"#{PlayerSeason.find(assists_player[0]).get_player_name}, (#{assists_player[1].size})"
	end

	private

	attr_reader :current_team_season, :next_match, :next_opponent

	def goals_against
		current_team_season.completed_fixtures.map { |f| f.goals.where.not(team_season_id: current_team_season.id) }.flatten
	end

	def yellow_cards_against
		current_team_season.completed_fixtures.map { |f| f.yellow_cards.where.not(team_season_id: current_team_season.id) }.flatten
	end

	def red_cards_against
		current_team_season.completed_fixtures.map { |f| f.red_cards.where.not(team_season_id: current_team_season.id) }.flatten
	end

	def assists_against
		current_team_season.completed_fixtures.map { |f| f.assists.where.not(team_season_id: current_team_season.id) }.flatten
	end
end
