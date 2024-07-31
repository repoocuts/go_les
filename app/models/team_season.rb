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
#  index_team_seasons_on_appearances_count   (appearances_count)
#  index_team_seasons_on_assists_count       (assists_count)
#  index_team_seasons_on_goals_count         (goals_count)
#  index_team_seasons_on_red_cards_count     (red_cards_count)
#  index_team_seasons_on_season_id           (season_id)
#  index_team_seasons_on_team_id             (team_id)
#  index_team_seasons_on_yellow_cards_count  (yellow_cards_count)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id) ON DELETE => cascade
#  fk_rails_...  (team_id => teams.id) ON DELETE => cascade
#
class TeamSeason < ApplicationRecord
	include TeamSeasonsHelper

	belongs_to :team
	belongs_to :season

	has_one :goals_scored_stat, class_name: 'TeamSeasons::GoalsScoredStat', dependent: :destroy
	has_one :goals_conceded_stat, class_name: 'TeamSeasons::GoalsConcededStat', dependent: :destroy
	has_one :yellow_cards_stat, class_name: 'TeamSeasons::YellowCardsStat', dependent: :destroy
	has_one :red_cards_stat, class_name: 'TeamSeasons::RedCardsStat', dependent: :destroy

	has_many :appearances
	has_many :player_seasons
	has_many :goals
	has_many :cards
	has_many :assists

	has_many :home_fixtures, -> { order(game_week: :asc) }, class_name: "Fixture", foreign_key: "home_team_season_id"
	has_many :away_fixtures, -> { order(game_week: :asc) }, class_name: "Fixture", foreign_key: "away_team_season_id"
	has_many :played_home_fixtures, -> { where.not(home_score: nil).order(game_week: :asc) }, class_name: "Fixture", foreign_key: "home_team_season_id"
	has_many :played_away_fixtures, -> { where.not(home_score: nil).order(game_week: :asc) }, class_name: "Fixture", foreign_key: "away_team_season_id"

	has_many :yellow_cards, -> { where(cards: { card_type: 'yellow' }) }, class_name: "Card", counter_cache: true, foreign_key: "team_season_id"
	has_many :red_cards, -> { where(cards: { card_type: 'red' }) }, class_name: "Card", counter_cache: true, foreign_key: "team_season_id"

	delegate :acronym, :name, :head_to_heads, :api_football_id, to: :team

	def next_fixture
		next_match
	end

	def next_fixture_opponent_team_object
		next_fixture_details.next_opponent_object
	end

	def next_opponent_string
		next_fixture_details.next_opponent_string
	end

	def next_fixture_home_or_away_identifier
		next_fixture_details.home_or_away_identifier
	end

	def previous_fixture
		previous_match
	end

	def last_fixture_opponent_name
		previous_fixture_details.previous_opponent_name
	end

	def last_fixture_result_string
		previous_fixture_details.previous_fixture_result_as_string
	end

	def last_fixture_opponent_string
		previous_fixture_details.previous_opponent_string
	end

	def top_scorer_player_season
		top_individual_player.top_scoring_player_season
	end

	def top_assisting_player_season
		top_individual_player.top_assists_player_season
	end

	def booked_players
		player_seasons.booked_players
	end

	def sent_off_players
		player_seasons.sent_off_players
	end

	def most_booked_player_season
		top_individual_player.most_booked_player_season
	end

	def most_reds_player_season
		top_individual_player.most_reds_player_season
	end

	def completed_fixtures
		all_fixture_details.completed_fixtures
	end

	def completed_fixtures_count
		all_fixture_details.completed_fixtures_size
	end

	def completed_fixtures_reversed
		all_fixture_details.completed_fixtures.reverse
	end

	def upcoming_fixtures
		all_fixture_details.remaining_fixtures
	end

	def upcoming_fixtures_reversed
		all_fixture_details.remaining_fixtures.reverse
	end

	def fixture_opponent_name(fixture)
		TeamSeasons::IndividualFixtureDetails.new(fixture:, team_season: self).fixture_opponent_name
	end

	def fixture_opponent_acronym(fixture)
		TeamSeasons::IndividualFixtureDetails.new(fixture:, team_season: self).fixture_opponent_acronym
	end

	def fixture_opponent_name_with_location_string(fixture)
		TeamSeasons::IndividualFixtureDetails.new(fixture:, team_season: self).fixture_opponent_name_with_location_string
	end

	def fixture_opponent_acronym_with_location_string(fixture)
		TeamSeasons::IndividualFixtureDetails.new(fixture:, team_season: self).fixture_opponent_acronym_with_location_string
	end

	def last_five_fixtures
		all_fixture_details.last_five_fixtures
	end

	def last_five_results
		all_fixture_details.last_five_results_hash
	end

	def played_home_matches_count
		played_home_matches.size
	end

	def played_away_matches_count
		played_away_matches.size
	end

	def played_home_fixtures
		played_home_matches
	end

	def played_away_fixtures
		played_away_matches
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
		total_goals_calculator.average_goals(type: :scored, half: :first_half)
	end

	def average_second_half_goals
		total_goals_calculator.average_goals(type: :scored, half: :second_half)
	end

	def average_goals_scored_per_match
		total_goals_calculator.average_goals(type: :scored)
	end

	def average_goals_conceded_per_match
		total_goals_calculator.average_goals(type: :conceded)
	end

	def home_goals_scored_count
		goals_scored_stat.home
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
		total_goals_calculator.average_goals(type: :conceded, location: :home)
	end

	def average_goals_conceded_away
		total_goals_calculator.average_goals(type: :conceded, location: :away)
	end

	def average_goals_scored_first_half
		total_goals_calculator.average_goals(type: :scored, half: :first_half)
	end

	def average_goals_scored_second_half
		total_goals_calculator.average_goals(type: :scored, half: :second_half)
	end

	def average_goals_scored_at_home
		total_goals_calculator.average_goals(type: :scored, location: :home)
	end

	def average_goals_scored_at_away
		total_goals_calculator.average_goals(type: :scored, location: :away)
	end

	def average_first_half_goals_conceded_home
		total_goals_calculator.average_goals(type: :conceded, half: :first_half, location: :home)
	end

	def average_first_half_goals_conceded_away
		total_goals_calculator.average_goals(type: :conceded, half: :first_half, location: :away)
	end

	def average_second_half_goals_conceded_home
		total_goals_calculator.average_goals(type: :conceded, half: :second_half, location: :home)
	end

	def average_second_half_goals_conceded_away
		total_goals_calculator.average_goals(type: :conceded, half: :second_half, location: :away)
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
		goals.first_half
	end

	def first_half_goals_total
		goals_scored_stat.first_half
	end

	def second_half_goals
		goals.second_half
	end

	def second_half_goals_total
		goals_scored_stat.second_half
	end

	def first_half_yellow_cards
		cards.first_half_yellow_cards(id)
	end

	def first_half_yellow_cards_total
		yellow_cards_stat.first_half
	end

	def second_half_yellow_cards
		cards.second_half_yellow_cards(id)
	end

	def second_half_yellow_cards_total
		yellow_cards_stat.second_half
	end

	def first_half_red_cards
		cards.first_half_red_cards(id)
	end

	def first_half_red_cards_total
		red_cards_stat.first_half
	end

	def second_half_red_cards
		cards.second_half_red_cards(id)
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
		fixture = head_to_heads.find_by(opponent_id: next_match_opponent_id)&.last_match_id
		return 'N/A' unless fixture

		get_fixture_result(fixture) if fixture.home_score
	end

	private

	attr_reader :total_goals_calculator

	def fixtures
		@fixtures ||= Fixture.for_team_season(id)
	end

	def next_match
		return @next_match if defined?(@next_match)

		@next_match = if fixtures.blank?
			              nil
			            elsif season.current_game_week == 1
				            fixtures.first
			            else
				            fixtures.find_by(game_week: season.current_game_week + 1)
		              end
	end

	def previous_match
		return @previous_match if defined?(@previous_match)

		@previous_match = if fixtures.blank? || season.current_game_week == 1
			                  nil
			                else
				                fixtures.find_by(game_week: season.current_game_week - 1)
		                  end
	end

	def get_fixture_result(fixture)
		return "#{fixture.home_score} - #{fixture.away_score}" if fixture.home_team_season_id == id

		"#{fixture.away_score} - #{fixture.home_score}"
	end

	def next_fixture_details
		@next_fixture_details ||= TeamSeasons::NextFixtureDetails.new(fixture: next_match, team_season: self)
	end

	def previous_fixture_details
		@previous_fixture_details ||= TeamSeasons::PreviousFixtureDetails.new(fixture: previous_match, team_season: self)
	end

	def all_fixture_details
		@all_fixture_details ||= TeamSeasons::AllFixtureDetails.new(team_season: self, fixtures:)
	end

	def top_individual_player
		@top_individual_player ||= TeamSeasons::TopIndividualPlayer.new(team_season: self)
	end

	def total_goals_calculator
		@total_goals_calculator ||=
			Calculators::Team::Goals.new(
				team_season: self,
			)
	end

	def total_yellow_cards_calculator
		@total_yellow_cards_calculator ||=
			Calculators::Team::YellowCards.new(
				yellow_cards_stat: yellow_cards_stat,
				completed_fixtures_count: completed_fixtures_count,
				home_fixtures_count: home_fixtures.count,
				away_fixtures_count: away_fixtures.count,
			)
	end

	def total_red_cards_calculator
		@total_red_cards_calculator ||=
			Calculators::Team::RedCards.new(
				red_cards_stat: red_cards_stat,
				completed_fixtures_count: completed_fixtures_count,
				home_fixtures_count: home_fixtures.count,
				away_fixtures_count: away_fixtures.count,
			)
	end

	def played_home_matches
		home_fixtures.where.not(home_score: nil)
	end

	def played_away_matches
		away_fixtures.where.not(away_score: nil)
	end
end
