# frozen_string_literal: true

class Team::PlayerVsOpponentComponent < ViewComponent::Base
	def initialize(current_team_season, next_match, next_opponent)
		@current_team_season = current_team_season
		@next_match = next_match
		@next_opponent = next_opponent
	end

	def rival_top_scorer
		scorer = matches_against_opponent&.goals&.where(team_season_id: next_opponent.id)&.group_by(&:player_season_id)&.max_by { |_k, v| v.size }&.flatten

		return 'No Scorer' if scorer.nil?

		link_to PlayerSeason.find(scorer[0]).return_name, player_path(scorer[0])
	end

	def top_scorer_against
		scorer = goals_against&.group_by(&:player_season_id)&.max_by { |_k, v| v.size }

		return 'No Scorer' if scorer.nil?

		link_to "#{PlayerSeason.find(scorer[0]).return_name}, (#{scorer[1].size})", player_path(scorer[0])
	end

	def most_booked_against
		booked_player = matches_against_opponent&.cards&.where(team_season_id: current_team_season.id)&.group_by(&:player_season_id)&.max_by { |_k, v| v.size }

		return 'No Bookings' if booked_player.nil?

		link_to "#{PlayerSeason.find(booked_player[0]).return_name}, (#{booked_player[1].size})", player_path(booked_player[0])
	end

	def rival_most_booked
		booked_player = yellow_cards_against&.group_by(&:player_season_id)&.max_by { |_k, v| v.size }

		return 'No Bookings' if booked_player.nil?

		link_to "#{PlayerSeason.find(booked_player[0]).return_name}, (#{booked_player[1].size})", player_path(booked_player[0])
	end

	def rival_most_reds
		reds_player = matches_against_opponent&.red_cards&.where(team_season_id: next_opponent.id)&.group_by(&:player_season_id)&.max_by { |_k, v| v.size }

		return 'No Reds' if reds_player.nil?

		PlayerSeason.find(reds_player[0]).return_name
	end

	def most_reds_against
		reds_player = red_cards_against&.group_by(&:player_season_id)&.max_by { |_k, v| v.size }

		return 'No Reds' if reds_player.nil?

		"#{PlayerSeason.find(reds_player[0]).return_name}, (#{reds_player[1].size})"
	end

	def most_assists_against
		assists_player = matches_against_opponent&.assists&.where(team_season_id: current_team_season.id)&.group_by(&:player_season_id)&.max_by { |_k, v| v.size }

		return 'No Assists' if assists_player.nil?

		link_to "#{PlayerSeason.find(assists_player[0]).return_name}, (#{assists_player[1].size})", player_path(assists_player[0])
	end

	def rival_most_assists
		assists_player = assists_against&.group_by(&:player_season_id)&.max_by { |_k, v| v.size }

		return 'No Assists' if assists_player.nil?

		"#{PlayerSeason.find(assists_player[0]).return_name}, (#{assists_player[1].size})"
	end

	private

	attr_reader :current_team_season, :next_match, :next_opponent

	def goals_against
		matches_against_opponent&.goals&.where&.not(team_season_id: next_opponent.id)
	end

	def yellow_cards_against
		matches_against_opponent&.cards&.where(team_season_id: next_opponent.id, card_type: 'yellow')
	end

	def red_cards_against
		matches_against_opponent&.red_cards&.where(team_season_id: next_opponent.id, card_type: 'red')
	end

	def assists_against
		matches_against_opponent&.assists&.where(team_season_id: next_opponent.id)
	end

	def matches_against_opponent
		@matches_against_opponent ||= current_team_season.completed_fixtures.where("home_team_season_id = ? OR away_team_season_id = ?", next_opponent.id, next_opponent.id).first
	end

end
