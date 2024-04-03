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
#  index_player_seasons_on_player_id       (player_id)
#  index_player_seasons_on_team_season_id  (team_season_id)
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

	ZERO = 0

	def get_player_name
		player.return_name
	end

	def team_acronym
		team_season.team.acronym
	end

	def team_name
		team_season.team.name
	end

	def season_goals
		goals.size
	end

	def season_assists
		assists.size
	end

	def season_yellows
		cards.where(card_type: "yellow").count
	end

	def season_reds
		cards.where(card_type: "red").count
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

	def average_minutes_per_goal
		return ZERO if season_goals.zero?

		total_minutes_played / season_goals
	end

	def home_goals
		goals.where(is_home: true).count
	end

	def away_goals
		goals.where(is_home: [false, nil]).count
	end

	def first_half_goals
		goals.where(minute: 0..45).count
	end

	def second_half_goals
		goals.where(minute: 46..100).count
	end

	def first_half_home_goals
		goals.where(minute: 0..45, is_home: true).count
	end

	def first_half_away_goals
		goals.where(minute: 0..45, is_home: nil).count
	end

	def second_half_home_goals
		goals.where(minute: 46..100, is_home: true).count
	end

	def second_half_away_goals
		goals.where(minute: 46..100, is_home: nil).count
	end

	def average_minutes_per_assist
		appearances.sum(:minutes) / season_assists if season_assists > 0

		ZERO
	end

	def home_assists
		assists.where(is_home: true).count
	end

	def away_assists
		assists.where(is_home: nil).count
	end

	def first_half_assists
		assists.where(minute: 0..45).count
	end

	def second_half_assists
		assists.where(minute: 46..100).count
	end

	def first_half_home_assists
		assists.where(minute: 0..45, is_home: true).count
	end

	def first_half_away_assists
		assists.where(minute: 0..45, is_home: nil).count
	end

	def second_half_home_assists
		assists.where(minute: 46..100, is_home: true).count
	end

	def second_half_away_assists
		assists.where(minute: 46..100, is_home: nil).count
	end
end
