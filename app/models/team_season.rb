# == Schema Information
#
# Table name: team_seasons
#
#  id                :bigint           not null, primary key
#  appearances_count :integer          default(0), not null
#  assists_count     :integer          default(0), not null
#  current_season    :boolean
#  goals_count       :integer          default(0), not null
#  points            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  api_football_id   :integer
#  season_id         :bigint           not null
#  team_id           :bigint           not null
#
# Indexes
#
#  index_team_seasons_on_season_id  (season_id)
#  index_team_seasons_on_team_id    (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#  fk_rails_...  (team_id => teams.id)
#
class TeamSeason < ApplicationRecord
	belongs_to :team
	belongs_to :season
	has_many :appearances
	has_many :player_seasons
	has_many :goals
	has_many :cards
	has_many :assists

	has_many :home_fixtures, -> { order(game_week: :asc) }, class_name: "Fixture", foreign_key: "home_team_season_id"
	has_many :away_fixtures, -> { order(game_week: :asc) }, class_name: "Fixture", foreign_key: "away_team_season_id"

	scope :current_season_goals, -> {
		joins(:season, :goals)
			.where(seasons: { current_season: true })
			.where('goals.team_season_id = team_seasons.id')
	}

	scope :current_season_home_goals, -> {
		joins(:season, :goals)
			.where(seasons: { current_season: true }, goals: { is_home: true })
	}

	def team_name
		team.name
	end

	def next_match
		all_fixtures_sorted_by_game_week.find_by(game_week: completed_fixtures.last.game_week + 1)
	end

	def next_match_opponent_name
		return next_match.home_team_name + home_or_away_string(next_match) if team.name == next_match.away_team_name

		next_match.away_team_name + home_or_away_string(next_match)
	end

	def next_match_opponent_id
		return next_match.home_team_season_id if team.name == next_match.away_team_name

		next_match.away_team_season_id
	end

	def last_match
		Fixture.find_by("game_week = ? AND (home_team_season_id = ? OR away_team_season_id = ?)", season.current_game_week, id, id)
	end

	def last_match_opponent_name
		return last_match.home_team_name if team.name == last_match.away_team_name

		last_match.away_team_name
	end

	def last_match_result
		if last_match.home_team_season_id == id
			"#{last_match.home_score} - #{last_match.away_score}"
		else
			"#{last_match.home_score} - #{last_match.away_score}"
		end
	end

	def last_match_details_string
		home_or_away_string(last_match).to_s + ' ' + last_match_opponent_name.to_s
	end

	def top_scorer
		player_seasons.includes([:player]).map { |ps| [ps.season_goals, ps.player.return_name, ps.player_id] }.sort! { |a, b| a.first <=> b.first }.reverse.first
	end

	def top_assists
		player_seasons.includes([:player]).map { |ps| [ps.assists_count, ps.player.return_name, ps.player_id] }.sort! { |a, b| a.first <=> b.first }.reverse.first
	end

	def booked_players
		player_seasons.booked_players
	end

	def sent_off_players
		player_seasons.sent_off_players
	end

	def most_booked_player
		player_seasons.booked_players.first || player_seasons.first
	end

	def most_reds_player
		player_seasons.sent_off_players.first || player_seasons.first
	end

	def home_or_away_string(match)
		return ' (H)' if match.home_team_season_id == id

		' (A)'
	end

	def all_fixtures_sorted_by_game_week
		Rails.cache.fetch("all_fixtures_sorted_by_game_week", expires_in: 12.hours) do
			Fixture.where('season_id = ? AND (home_team_season_id = ? OR away_team_season_id = ?)', season_id, id, id).order(:game_week)
		end
	end

	def completed_fixtures
		all_fixtures_sorted_by_game_week.where('kick_off < ?', Date.today)
	end

	def completed_fixtures_count
		completed_fixtures.size
	end

	def upcoming_fixtures
		all_fixtures_sorted_by_game_week.where(home_score: nil)
	end

	def completed_fixtures_reversed
		all_fixtures_sorted_by_game_week.where.not(home_score: nil).reverse
	end

	def upcoming_fixtures_reversed
		all_fixtures_sorted_by_game_week.where(home_score: nil).reverse
	end

	def match_opponent_name(match)
		return match.home_team_name if team.name == match.away_team_name

		match.away_team_name
	end

	def last_five_matches
		completed_fixtures.last(5)
	end

	def last_five_results
		last_five_matches.map do |match|
			results_formatter(match)
		end
	end

	def played_home_matches
		Fixture.where(id: completed_fixtures_reversed(&:id)).where(home_team_season_id: id)
	end

	def played_away_matches
		Fixture.where(id: completed_fixtures_reversed(&:id)).where(away_team_season_id: id)
	end

	def goals_for
		Goal.for_team_season(id)
	end

	def goals_against
		ids = completed_fixtures.pluck(:id)

		goals = Goal.where(fixture_id: ids)
		goals.where.not(team_season_id: id)
	end

	def goals_against_number
		goals_against.size
	end

	def top_scorers
		player_seasons.scorers.first(3)
	end

	def average_first_half_goals
		(first_half_goals.size / completed_fixtures.size.to_f).round(2)
	end

	def average_second_half_goals
		(second_half_goals.size / completed_fixtures.size.to_f).round(2)
	end

	def average_goals_scored_per_match
		(goals.size.to_f / completed_fixtures.size.to_f).round(2)
	end

	def average_goals_conceded_per_match
		(goals_against.size.to_f / completed_fixtures.size).round(2)
		(goals_against.size.to_f / completed_fixtures.size).round(2)
	end

	def home_goals_conceded
		goals_against.where(is_home: false)
	end

	def away_goals_conceded
		goals_against.where(is_home: true)
	end

	def home_goals_conceded_count
		goals_against.where.not(team_season_id: id, is_home: true).size
	end

	def away_goals_conceded_count
		goals_against.where.not(team_season_id: id, is_home: false).size
	end

	def first_half_goals_conceded_count
		(home_goals_conceded.where('minute < ?', 46) + away_goals_conceded.where('minute < ?', 46)).size
	end

	def second_half_goals_conceded_count
		(home_goals_conceded.where('minute > ?', 45) + away_goals_conceded.where('minute > ?', 46)).size
	end

	def average_goals_conceded_home
		(home_goals_conceded_count / completed_fixtures.size.to_f).round(2)
	end

	def average_goals_conceded_away
		(away_goals_conceded_count / completed_fixtures.size.to_f).round(2)
	end

	def average_goals_scored_first_half
		(goals.size.to_f / completed_fixtures.size).round(2)
	end

	def average_goals_scored_second_half
		(goals.size.to_f / completed_fixtures.size).round(2)
	end

	def average_goals_scored_at_home
		(goals.size.to_f / completed_fixtures.size).round(2)
	end

	def average_goals_scored_at_away
		(goals.size.to_f / completed_fixtures.size).round(2)
	end

	def average_first_half_goals_conceded_home
		(home_goals_conceded.where('minute < ?', 46).size / completed_fixtures.size.to_f.round(2))
		0
	end

	def average_first_half_goals_conceded_away
		(away_goals_conceded.where('minute < ?', 46).size / completed_fixtures.size.to_f.round(2))
		0
	end

	def average_second_half_goals_conceded_home
		(home_goals_conceded.where('minute > ?', 46).size / completed_fixtures.size.to_f.round(2))
		0
	end

	def average_second_half_goals_conceded_away
		(away_goals_conceded.where('minute > ?', 46).size / completed_fixtures.size.to_f.round(2))
	end

	def first_half_home_goals_conceded
		home_goals_conceded.where('minute < ?', 46).size
	end

	def second_half_home_goals_conceded
		home_goals_conceded.where('minute > ?', 45).size
	end

	def first_half_away_goals_conceded
		away_goals_conceded.where('minute < ?', 46).size
	end

	def second_half_away_goals_conceded
		away_goals_conceded.where('minute > ?', 45).size
	end

	def first_half_goals
		Goal.first_half_goals(id)
	end

	def first_half_goals_total
		first_half_goals.size
	end

	def second_half_goals
		Goal.second_half_goals(id)
	end

	def second_half_goals_total
		second_half_goals.size
	end

	def first_half_yellow_cards
		Card.first_half_yellow_cards(id)
	end

	def first_half_yellow_cards_total
		first_half_yellow_cards.size
	end

	def second_half_yellow_cards
		Card.second_half_yellow_cards(id)
	end

	def second_half_yellow_cards_total
		second_half_yellow_cards.size
	end

	def first_half_red_cards
		Card.first_half_red_cards(id)
	end

	def first_half_red_cards_total
		first_half_red_cards.size
	end

	def second_half_red_cards
		Card.second_half_red_cards(id)
	end

	def second_half_red_cards_total
		second_half_red_cards.size
	end

	def yellow_card_count
		yellow_cards.size
	end

	def red_card_count
		red_cards.size
	end

	private

	def results_formatter(match, hash: {})
		outcome = if match.home_score.nil?
			          '-'
			        elsif match.home_team_season_id == self.id
				        if match.home_score > match.away_score
					        'W'
				        elsif match.home_score == match.away_score
					        'D'
				        else
					        'L'
				        end
			        else
				        if match.away_score > match.home_score
					        'W'
				        elsif match.home_score == match.away_score
					        'D'
				        else
					        'L'
				        end
		          end

		hash[match.game_week] = outcome
		hash
	end

end
