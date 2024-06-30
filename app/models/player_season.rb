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
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
class PlayerSeason < ApplicationRecord
	belongs_to :player
	belongs_to :team_season
	has_many :appearances
	has_many :goals
	has_many :cards
	has_many :assists

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

	def return_team_name
		team_name
	end

	def return_team_acronym
		team_acronym
	end

	def season_goals_size
		goals.size
	end

	def season_assists_size
		assists.size
	end

	def season_yellows_count
		yellow_cards.count
	end

	def season_home_yellows_count
		yellow_cards.where(is_home: true).count
	end

	def season_away_yellows_count
		yellow_cards.where(is_home: [false, nil]).count
	end

	def season_reds_count
		red_cards.count
	end

	def season_home_reds_count
		red_cards.where(is_home: true).count
	end

	def season_away_reds_count
		red_cards.where(is_home: [false, nil]).count
	end

	def sub_appearances
		appearances.where(appearance_type: 'substitute')
	end

	def starts
		appearances.where(appearance_type: 'start')
	end

	def self.sorted_by(column, direction)
		case column
		when 'full_name'
			joins(:player).order("players.full_name #{direction}")
		when 'position'
			joins(:player).order("players.position #{direction}")
		when 'appearances'
			joins(:appearances).group('player_seasons.id').order("COUNT(appearances.id) #{direction}")
		when 'goals'
			joins(:goals).group('player_seasons.id').order("COUNT(goals.id) #{direction}")
		when 'yellow_cards'
			joins(:cards).where(cards: { card_type: 'yellow' }).group('player_seasons.id').order("COUNT(cards.id) #{direction}")
		when 'red_cards'
			joins(:cards).where(cards: { card_type: 'red' }).group('player_seasons.id').order("COUNT(cards.id) #{direction}")
		else
			joins(:player).order("players.position #{direction}") # default order
		end
	end

	def total_minutes_played
		appearances.sum(:minutes)
	end

	def total_home_minutes_played
		home_appearances.sum(:minutes)
	end

	def total_away_minutes_played
		appearances.where(is_home: [false, nil]).sum(:minutes)
	end

	def average_minutes_per_goal
		return ZERO if season_goals_size.zero?

		total_minutes_played / season_goals_size
	end

	def average_minutes_per_home_goal
		return ZERO if season_goals_size.zero?

		total_home_minutes_played / home_goals_count
	end

	def average_minutes_per_away_goal
		return ZERO if season_goals_size.zero?

		total_away_minutes_played / away_goals_count
	end

	def home_goals_count
		goals.where(is_home: true).count
	end

	def away_goals_count
		goals.where(is_home: [false, nil]).count
	end

	def first_half_goals_count
		first_half_goals.count
	end

	def second_half_goals_count
		goals.where(minute: 46..100).count
	end

	def first_half_home_goals_count
		first_half_goals.where(is_home: true).count
	end

	def first_half_away_goals_count
		first_half_goals.where(is_home: nil).count
	end

	def second_half_home_goals_count
		second_half_goals.where(is_home: true).count
	end

	def second_half_away_goals_count
		second_half_goals.where(is_home: nil).count
	end

	def average_minutes_per_assist
		appearances.sum(:minutes) / season_assists_size if season_assists_size > 0

		ZERO
	end

	def average_minutes_per_home_assist
		return home_appearances.sum(:minutes) / home_assists_count if home_assists_count > 0

		ZERO
	end

	def average_minutes_per_away_assist
		return away_appearances.sum(:minutes) / away_assists_count if away_assists_count > 0

		ZERO
	end

	def home_assists_count
		assists.where(is_home: true).count
	end

	def away_assists_count
		assists.where(is_home: nil).count
	end

	def first_half_assists_count
		first_half_assists.count
	end

	def second_half_assists_count
		second_half_assists.count
	end

	def first_half_home_assists_count
		first_half_assists.where(is_home: true).count
	end

	def first_half_away_assists_count
		first_half_assists.where(is_home: nil).count
	end

	def second_half_home_assists_count
		second_half_assists.where(is_home: true).count
	end

	def second_half_away_assists_count
		second_half_assists.where(is_home: nil).count
	end

	def first_half_home_yellow_cards_count
		first_half_yellow_cards.where(is_home: true).count
	end

	def first_half_away_yellow_cards_count
		first_half_yellow_cards.where(is_home: [false, nil]).count
	end

	def second_half_home_yellow_cards_count
		second_half_yellow_cards.where(is_home: true).count
	end

	def second_half_away_yellow_cards_count
		second_half_yellow_cards.where(is_home: [false, nil]).count
	end

	def average_minutes_per_home_yellow_card
		return home_appearances.sum(:minutes) / season_home_yellows_count if season_home_yellows_count > 0

		ZERO
	end

	def average_minutes_per_away_yellow_card
		return away_appearances.sum(:minutes) / season_away_yellows_count if season_away_yellows_count > 0

		ZERO
	end

	def first_half_home_red_cards_count
		first_half_red_cards.where(is_home: true).count
	end

	def first_half_away_red_cards_count
		first_half_red_cards.where(is_home: [false, nil]).count
	end

	def second_half_home_red_cards_count
		second_half_red_cards.where(is_home: true).count
	end

	def second_half_away_red_cards_count
		second_half_red_cards.where(is_home: [false, nil]).count
	end

	def average_minutes_per_home_red_card
		return home_appearances.sum(:minutes) / season_home_reds_count if season_home_reds_count > 0

		ZERO
	end

	def average_minutes_per_away_red_card
		return away_appearances.sum(:minutes) / season_away_reds_count if season_away_reds_count > 0

		ZERO
	end

	private

	def team_name
		@team_name ||= team_season.name
	end

	def team_acronym
		@team_acronym ||= team_season.acronym
	end

	def yellow_cards
		@yellow_cards ||= cards.where(card_type: "yellow")
	end

	def first_half_yellow_cards
		@first_half_yellow_cards ||= yellow_cards.where(minute: 0..45)
	end

	def second_half_yellow_cards
		@second_half_yellow_cards ||= yellow_cards.where(minute: 46..100)
	end

	def red_cards
		@red_cards ||= cards.where(card_type: "red")
	end

	def first_half_red_cards
		@first_half_red_cards ||= red_cards.where(minute: 0..45)
	end

	def second_half_red_cards
		@second_half_red_cards ||= red_cards.where(minute: 46..100)
	end

	def home_appearances
		@home_appearances ||= appearances.where(is_home: true)
	end

	def away_appearances
		@away_appearances ||= appearances.where(is_home: false)
	end

	def first_half_assists
		@first_half_assists ||= assists.where(minute: 0..45)
	end

	def second_half_assists
		@second_half_assists ||= assists.where(minute: 46..100)
	end

	def home_goals
		@home_goals ||= goals.where(is_home: true)
	end

	def away_goals
		@away_goals ||= goals.where(is_home: [false, nil])
	end

	def first_half_goals
		@first_half_goals ||= goals.where(minute: 0..45)
	end

	def second_half_goals
		@second_half_goals ||= goals.where(minute: 46..100)
	end
end
