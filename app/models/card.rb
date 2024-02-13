# == Schema Information
#
# Table name: cards
#
#  id                 :bigint           not null, primary key
#  card_type          :string
#  is_home            :boolean
#  minute             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  appearance_id      :bigint           not null
#  first_card_id      :integer
#  fixture_id         :bigint           not null
#  player_season_id   :bigint           not null
#  referee_fixture_id :integer
#  team_season_id     :bigint           not null
#
# Indexes
#
#  index_cards_on_appearance_id     (appearance_id)
#  index_cards_on_fixture_id        (fixture_id)
#  index_cards_on_player_season_id  (player_season_id)
#  index_cards_on_team_season_id    (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (appearance_id => appearances.id)
#  fk_rails_...  (fixture_id => fixtures.id)
#  fk_rails_...  (player_season_id => player_seasons.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
class Card < ApplicationRecord
	belongs_to :appearance
	belongs_to :player_season
	belongs_to :team_season, counter_cache: :yellow_cards_count
	belongs_to :fixture

	scope :home_cards, ->(fixture) { where(is_home: true, fixture_id: fixture.id) }
	scope :away_cards, ->(fixture) { where(is_home: nil, fixture_id: fixture.id) }
	scope :home_yellow_cards, ->(fixture) { where(is_home: true, fixture_id: fixture.id, card_type: 'yellow') }
	scope :away_yellow_cards, ->(fixture) { where(is_home: nil, fixture_id: fixture.id, card_type: 'yellow') }
	scope :home_red_cards, ->(fixture) { where(is_home: true, fixture_id: fixture.id, card_type: 'red') }
	scope :away_red_cards, ->(fixture) { where(is_home: nil, fixture_id: fixture.id, card_type: 'red') }
	scope :yellow_cards, -> { where(card_type: 'yellow') }
	scope :red_cards, -> { where(card_type: 'red') }
	scope :yellow_cards_for_team_season, ->(team_season_id) { where(card_type: 'yellow', team_season_id: team_season_id) }
	scope :red_cards_for_team_season, ->(team_season_id) { where(card_type: 'red', team_season_id: team_season_id) }
	scope :first_half_yellow_cards, ->(team_season_id) { yellow_cards.where('minute < ? AND team_season_id = ?', 46, team_season_id) }
	scope :second_half_yellow_cards, ->(team_season_id) { yellow_cards.where('minute > ? AND team_season_id = ?', 45, team_season_id) }
	scope :first_half_red_cards, ->(team_season_id) { red_cards.where('minute < ? AND team_season_id = ?', 46, team_season_id) }
	scope :second_half_red_cards, ->(team_season_id) { red_cards.where('minute > ? AND team_season_id = ?', 45, team_season_id) }
	scope :group_by_player_season, -> { group(:player_season_id) }
	scope :by_season, -> (season_id) {
		joins(team_season: :season)
			.where('seasons.id = ?', season_id)
			.includes(:player_season, :team_season)
			.group(:player_season_id)
			.order('COUNT(cards.id) desc')
			.count('cards.id')
	}

	def card_receiver_name
		player_season.get_player_name
	end

	def card_team_name
		team_season.team_name
	end

end
