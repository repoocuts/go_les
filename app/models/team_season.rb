# == Schema Information
#
# Table name: team_seasons
#
#  id                 :bigint           not null, primary key
#  appearances_count  :integer          default(0), not null
#  assists_count      :integer          default(0), not null
#  current_season     :boolean
#  goals_count        :integer          default(0), not null
#  points             :integer
#  red_cards_count    :integer          default(0), not null
#  yellow_cards_count :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  api_football_id    :integer
#  season_id          :bigint           not null
#  team_id            :bigint           not null
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

	has_one :goals_scored_stat
	has_one :goals_conceded_stat
	has_one :yellow_cards_stat
	has_one :red_cards_stat

	has_many :appearances
	has_many :player_seasons
	has_many :goals
	has_many :cards
	has_many :assists

	has_many :home_fixtures, -> { order(game_week: :asc) }, class_name: "Fixture", foreign_key: "home_team_season_id"
	has_many :away_fixtures, -> { order(game_week: :asc) }, class_name: "Fixture", foreign_key: "away_team_season_id"
	has_many :yellow_cards, -> { where(cards: { card_type: 'yellow' }) }, class_name: "Card", counter_cache: true, foreign_key: "team_season_id"
	has_many :red_cards, -> { where(cards: { card_type: 'red' }) }, class_name: "Card", counter_cache: true, foreign_key: "team_season_id"

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

	def fixtures
		Fixture.where("home_team_season_id = ? OR away_team_season_id = ?", id, id).order(game_week: :asc, kick_off: :asc)
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
		completed_fixtures.last
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
		player_seasons.order(:goals_count).reverse.first
	end

	def top_assists
		player_seasons.order(:assists_count).reverse.first
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
		fixtures.order(:game_week, :kick_off)
	end

	def completed_fixtures
		all_fixtures_sorted_by_game_week.where('kick_off < ? AND home_score IS NOT NULL', Date.today)
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
		return match.home_team_name if id == match.away_team_season_id

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
		home_fixtures.where.not(home_score: nil)
	end

	def played_away_matches
		away_fixtures.where.not(away_score: nil)
	end

	def goals_for
		goals
	end

	def goals_against_number
		goals_conceded_stat.total
	end

	def goal_difference
		total_goals_calculator.goal_difference
	end

	def top_scorers
		player_seasons.scorers.first(3)
	end

	def average_first_half_goals
		total_goals_calculator.average_first_half_goals
	end

	def average_second_half_goals
		total_goals_calculator.average_second_half_goals
	end

	def average_goals_scored_per_match
		total_goals_calculator.average_goals_scored_per_match
	end

	def average_goals_conceded_per_match
		total_goals_calculator.average_goals_conceded_per_match
	end

	def home_goals_scored_count
		goals_scored_stat.home
	end

	def away_goals_scored
		goals_for.select { |goal| goal.is_home.nil? }
	end

	def away_goals_scored_count
		goals_scored_stat.away
	end

	def home_goals_conceded_count
		goals_conceded_stat.home
	end

	def away_goals_conceded_count
		goals_conceded_stat.away
	end

	def first_half_goals_conceded_count
		goals_conceded_stat.home_first_half
	end

	def second_half_goals_conceded_count
		goals_conceded_stat.second_half
	end

	def average_goals_conceded_home
		total_goals_calculator.average_goals_conceded_home
	end

	def average_goals_conceded_away
		total_goals_calculator.average_goals_conceded_away
	end

	def average_goals_scored_first_half
		total_goals_calculator.average_goals_scored_first_half
	end

	def average_goals_scored_second_half
		total_goals_calculator.average_goals_scored_second_half
	end

	def average_goals_scored_at_home
		total_goals_calculator.average_goals_scored_home
	end

	def average_goals_scored_at_away
		total_goals_calculator.average_goals_scored_away
	end

	def average_first_half_goals_conceded_home
		# (home_goals_conceded.where('minute < ?', 46).size / completed_fixtures.size.to_f.round(2))
		0
	end

	def average_first_half_goals_conceded_away
		total_goals_calculator.average_goals_conceded_away_first_half
	end

	def average_second_half_goals_conceded_home
		total_goals_calculator.average_goals_conceded_home_second_half
	end

	def average_second_half_goals_conceded_away
		total_goals_calculator.average_goals_conceded_away_second_half
	end

	def first_half_home_goals_conceded
		goals_conceded_stat.home_first_half
	end

	def second_half_home_goals_conceded
		goals_conceded_stat.home_second_half
	end

	def first_half_away_goals_conceded
		goals_conceded_stat.away_first_half
	end

	def second_half_away_goals_conceded
		goals_conceded_stat.away_second_half
	end

	def first_half_goals
		total_goals_calculator.first_half_goals
	end

	def first_half_goals_total
		goals_scored_stat.first_half
	end

	def second_half_goals
		goals.where('minute > ?', 45)
	end

	def second_half_goals_total
		goals_scored_stat.second_half
	end

	def first_half_yellow_cards
		Card.first_half_yellow_cards(id)
	end

	def first_half_yellow_cards_total
		yellow_cards_stat.first_half
	end

	def second_half_yellow_cards
		Card.second_half_yellow_cards(id)
	end

	def second_half_yellow_cards_total
		yellow_cards_stat.second_half
	end

	def first_half_red_cards
		Card.first_half_red_cards(id)
	end

	def first_half_red_cards_total
		red_cards_stat.first_half
	end

	def second_half_red_cards
		Card.second_half_red_cards(id)
	end

	def second_half_red_cards_total
		red_cards_stat.second_half
	end

	def yellow_card_count
		yellow_cards_stat.total
	end

	def home_yellow_cards
		yellow_cards_stat.home
	end

	def away_yellow_cards
		yellow_cards_stat.away
	end

	def red_card_count
		red_cards_stat.total
	end

	def home_red_cards
		red_cards_stat.home
	end

	def away_red_cards
		red_cards_stat.away
	end

	def average_first_half_yellow_cards
		total_yellow_cards_calculator.average_first_half_yellow_cards
	end

	def last_match_vs_opponent(next_match_opponent_id)
		fixture = (fixtures.where("home_team_season_id = ? OR away_team_season_id = ?", next_match_opponent_id, next_match_opponent_id) - [next_match]).first
		return get_fixture_result(fixture) if fixture.home_score

		last_season = season.league.last_season
		return 'N/A' unless last_season.present?

		first_fixture = Fixture.find_by(home_team_season_id: id, away_team_season_id: next_match_opponent_id, season_id: last_season.id)
		second_fixture = Fixture.find_by(home_team_season_id: next_match_opponent_id, away_team_season_id: id, season_id: last_season.id)
		return get_fixture_result(first_fixture) if first_fixture && first_fixture.game_week > second_fixture.game_week

		return 'N/A' unless second_fixture
			
		get_fixture_result(second_fixture)
	end

	private

	attr_reader :total_goals_calculator
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

	def get_fixture_result(fixture)
		return "#{fixture.home_score} - #{fixture.away_score}" if fixture.home_team_season_id == id

		"#{fixture.away_score} - #{fixture.home_score}"
	end

	def total_goals_calculator
		@total_goals_calculator ||=
			Calculators::TeamGoals::GoalsCalculator.new(
				goals_scored_stat: goals_scored_stat,
				goals_conceded_stat: goals_conceded_stat,
				completed_fixtures_count: completed_fixtures_count,
				home_fixtures_count: home_fixtures.count,
				away_fixtures_count: away_fixtures.count,
			)
	end

	def total_yellow_cards_calculator
		@total_yellow_cards_calculator ||=
			Calculators::TeamCards::YellowCardsCalculator.new(
				yellow_cards_stat: yellow_cards_stat,
				completed_fixtures_count: completed_fixtures_count,
				home_fixtures_count: home_fixtures.count,
				away_fixtures_count: away_fixtures.count,
			)
	end

	def total_red_cards_calculator
		@total_red_cards_calculator ||=
			Calculators::TeamCards::RedCardsCalculator.new(
				red_cards_stat: red_cards_stat,
				completed_fixtures_count: completed_fixtures_count,
				home_fixtures_count: home_fixtures.count,
				away_fixtures_count: away_fixtures.count,
			)
	end

end
