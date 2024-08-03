# == Schema Information
#
# Table name: player_seasons
#
#  id                :bigint           not null, primary key
#  appearances_count :integer          default(0), not null
#  assists_count     :integer          default(0), not null
#  current_season    :boolean
#  goals_count       :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  api_football_id   :integer
#  player_id         :bigint           not null
#  team_season_id    :bigint           not null
#
# Indexes
#
#  index_player_seasons_on_appearances_count               (appearances_count)
#  index_player_seasons_on_assists_count                   (assists_count)
#  index_player_seasons_on_goals_count                     (goals_count)
#  index_player_seasons_on_player_id                       (player_id)
#  index_player_seasons_on_team_season_id                  (team_season_id)
#  index_player_seasons_on_team_season_id_and_goals_count  (team_season_id,goals_count)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id) ON DELETE => cascade
#  fk_rails_...  (team_season_id => team_seasons.id) ON DELETE => cascade
#
class PlayerSeason < ApplicationRecord
	belongs_to :player
	belongs_to :team_season
	has_many :appearances
	has_many :goals
	has_many :cards
	has_many :assists
	has_one :season, through: :team_season
	has_one :player_seasons_attacking_stat, :class_name => 'PlayerSeasons::AttackingStat', dependent: :destroy
	has_one :player_seasons_defensive_stat, :class_name => 'PlayerSeasons::DefensiveStat', dependent: :destroy
	has_one :player_seasons_discipline_stat, :class_name => 'PlayerSeasons::DisciplineStat', dependent: :destroy

	scope :scorers, -> { joins(:goals).reverse }
	scope :booked_players, -> { joins(:cards).where('cards.card_type = ?', "yellow") }
	scope :sent_off_players, -> { joins(:cards).where('cards.card_type = ?', "red") }
	scope :with_goals, -> { where.not(goals_count: 0) }
	scope :with_assists, -> { where.not(assists_count: 0) }
	scope :booked_players_with_count, -> {
		joins(:cards)
			.select('player_seasons.id, player_seasons.player_id, player_seasons.team_season_id, COUNT(cards.id) AS cards_count')
			.where(cards: { card_type: 'yellow' })
			.group('player_seasons.id')
	}
	scope :sent_off_players_with_count, -> {
		joins(:cards)
			.select('player_seasons.id, player_seasons.player_id, player_seasons.team_season_id, COUNT(cards.id) AS cards_count')
			.where(cards: { card_type: 'red' })
			.group('player_seasons.id')
	}

	delegate :return_name, to: :player, prefix: false

	ZERO = 0

	def self.sorted_by(column, direction)
		case column
		when 'full_name'
			joins(:player).order("players.full_name #{direction}, players.short_name #{direction}")
		when 'position'
			joins(:player).order(Arel.sql("CASE players.position
                                      WHEN 'goalkeeper' THEN 1
                                      WHEN 'defender' THEN 2
                                      WHEN 'midfielder' THEN 3
                                      WHEN 'attacker' THEN 4
                                      ELSE 5 END #{direction}"))
		when 'appearances'
			order("appearances_count #{direction}")
		when 'goals'
			order("goals_count #{direction}")
		when 'yellow_cards'
			joins(:cards).where(cards: { card_type: 'yellow' }).group('player_seasons.id').order("COUNT(cards.id) #{direction}")
		when 'red_cards'
			joins(:cards).where(cards: { card_type: 'red' }).group('player_seasons.id').order("COUNT(cards.id) #{direction}")
		else
			joins(:player).order(Arel.sql("CASE players.position
                                      WHEN 'goalkeeper' THEN 1
                                      WHEN 'defender' THEN 2
                                      WHEN 'midfielder' THEN 3
                                      WHEN 'attacker' THEN 4
                                      ELSE 5 END #{direction}"))
		end
	end

	def return_team_name
		team_name
	end

	def return_team_acronym
		team_acronym
	end

	def season_goals_size
		goals_calculator.season_goals_size
	end

	def home_goals_count
		goals_calculator.home_goals_count
	end

	def away_goals_count
		goals_calculator.away_goals_count
	end

	def first_half_goals_count
		goals_calculator.first_half_goals_count
	end

	def second_half_goals_count
		goals_calculator.second_half_goals_count
	end

	def first_half_home_goals_count
		goals_calculator.first_half_home_goals_count
	end

	def first_half_away_goals_count
		goals_calculator.first_half_away_goals_count
	end

	def second_half_home_goals_count
		goals_calculator.second_half_home_goals_count
	end

	def second_half_away_goals_count
		goals_calculator.second_half_away_goals_count
	end

	def average_minutes_per_goal
		goals_calculator.average_minutes_per_goal
	end

	def average_minutes_per_home_goal
		goals_calculator.average_minutes_per_home_goal
	end

	def average_minutes_per_away_goal
		goals_calculator.average_minutes_per_away_goal
	end

	def season_assists_size
		assists_calculator.season_assists_size
	end

	def home_assists_count
		assists_calculator.home_assists_count
	end

	def away_assists_count
		assists_calculator.away_assists_count
	end

	def first_half_assists_count
		assists_calculator.first_half_assists_count
	end

	def second_half_assists_count
		assists_calculator.second_half_assists_count
	end

	def first_half_home_assists_count
		assists_calculator.first_half_home_assists_count
	end

	def first_half_away_assists_count
		assists_calculator.first_half_away_assists_count
	end

	def second_half_home_assists_count
		assists_calculator.second_half_home_assists_count
	end

	def second_half_away_assists_count
		assists_calculator.second_half_away_assists_count
	end

	def average_minutes_per_assist
		assists_calculator.average_minutes_per_assist
	end

	def average_minutes_per_home_assist
		assists_calculator.average_minutes_per_home_assist
	end

	def average_minutes_per_away_assist
		assists_calculator.average_minutes_per_away_assist
	end

	def season_yellows_count
		cards_calculator.season_yellows_count
	end

	def season_home_yellows_count
		cards_calculator.season_home_yellows_count
	end

	def season_away_yellows_count
		cards_calculator.season_away_yellows_count
	end

	def season_reds_count
		cards_calculator.season_reds_count
	end

	def season_home_reds_count
		cards_calculator.season_home_reds_count
	end

	def season_away_reds_count
		cards_calculator.season_away_reds_count
	end

	def first_half_home_yellow_cards_count
		cards_calculator.first_half_home_yellow_cards_count
	end

	def first_half_away_yellow_cards_count
		cards_calculator.first_half_away_yellow_cards_count
	end

	def second_half_home_yellow_cards_count
		cards_calculator.second_half_home_yellow_cards_count
	end

	def second_half_away_yellow_cards_count
		cards_calculator.second_half_away_yellow_cards_count
	end

	def first_half_home_red_cards_count
		cards_calculator.first_half_home_red_cards_count
	end

	def first_half_away_red_cards_count
		cards_calculator.first_half_away_red_cards_count
	end

	def second_half_home_red_cards_count
		cards_calculator.second_half_home_red_cards_count
	end

	def second_half_away_red_cards_count
		cards_calculator.second_half_away_red_cards_count
	end

	def average_minutes_per_home_yellow_card
		cards_calculator.average_minutes_per_home_yellow_card
	end

	def average_minutes_per_away_yellow_card
		cards_calculator.average_minutes_per_away_yellow_card
	end

	def average_minutes_per_home_red_card
		cards_calculator.average_minutes_per_home_red_card
	end

	def average_minutes_per_away_red_card
		cards_calculator.average_minutes_per_away_red_card
	end

	def total_minutes_played
		appearances_calculator.total_minutes_played
	end

	def total_home_minutes_played
		appearances_calculator.total_home_minutes_played
	end

	def total_away_minutes_played
		appearances_calculator.total_away_minutes_played
	end

	def sub_appearances
		appearances_calculator.sub_appearances
	end

	def starts
		appearances_calculator.starts
	end

	private

	def team_name
		@team_name ||= team_season.name
	end

	def team_acronym
		@team_acronym ||= team_season.acronym
	end

	def goals_calculator
		@goals_calculator ||= ::Calculators::PlayerSeason::Goals.new(self)
	end

	def assists_calculator
		@assists_calculator ||= ::Calculators::PlayerSeason::Assists.new(self)
	end

	def cards_calculator
		@cards_calculator ||= ::Calculators::PlayerSeason::Cards.new(self)
	end

	def appearances_calculator
		@appearances_calculator ||= ::Calculators::PlayerSeason::Appearances.new(self)
	end
end
