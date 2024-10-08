# == Schema Information
#
# Table name: appearances
#
#  id               :bigint           not null, primary key
#  appearance_type  :string
#  assists_count    :integer          default(0), not null
#  goals_count      :integer          default(0), not null
#  is_home          :boolean
#  minutes          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fixture_id       :bigint           not null
#  player_season_id :bigint           not null
#  team_season_id   :bigint           not null
#
# Indexes
#
#  index_appearances_on_fixture_id        (fixture_id)
#  index_appearances_on_player_season_id  (player_season_id)
#  index_appearances_on_team_season_id    (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (fixture_id => fixtures.id) ON DELETE => cascade
#  fk_rails_...  (player_season_id => player_seasons.id) ON DELETE => cascade
#  fk_rails_...  (team_season_id => team_seasons.id) ON DELETE => cascade
#
class Appearance < ApplicationRecord
	belongs_to :team_season, counter_cache: true
	belongs_to :player_season, counter_cache: true
	belongs_to :fixture

	has_many :goals, dependent: :destroy
	has_many :cards, dependent: :destroy
	has_many :assists, dependent: :destroy

	scope :home_starts, -> { where(is_home: true, appearance_type: 'start') }
	scope :away_starts, -> { where(is_home: nil, appearance_type: 'start') }
	scope :home_subs, -> { where(is_home: true, appearance_type: 'substitute') }
	scope :away_subs, -> { where(is_home: nil, appearance_type: 'substitute') }

	def create_appearance_for_player(player_id, fixture, team_season, is_home = nil)
		update(
			player_season: get_player_season(player_id),
			team_season_id: team_season.id,
			fixture_id: fixture.id,
			appearance_type: 'start',
			is_home: is_home,
			minutes: 90
		)
	end

	def appearance_player_name
		player_season.return_name
	end

	def appearance_team_name
		team_season.name
	end

	def yellow_cards
		cards.yellow_cards
	end

	def red_cards
		cards.red_cards
	end

	def card_counts
		cards.group(:card_type).count
	end

	def yellow_card_count
		card_counts["yellow"] || 0
	end

	def red_card_count
		card_counts["red"] || 0
	end

	private

	def get_player_season(player_id)
		Player.find_by(api_football_id: player_id).current_player_season
	end
end
