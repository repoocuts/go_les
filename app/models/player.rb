# == Schema Information
#
# Table name: players
#
#  id              :bigint           not null, primary key
#  full_name       :string
#  position        :string
#  short_name      :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  team_id         :bigint
#
# Indexes
#
#  index_players_on_full_name   (full_name)
#  index_players_on_short_name  (short_name)
#  index_players_on_slug        (slug) UNIQUE
#  index_players_on_team_id     (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id) ON DELETE => nullify
#
class Player < ApplicationRecord
	extend FriendlyId
	friendly_id :full_name, use: :slugged

	belongs_to :team, optional: true
	has_many :player_seasons, dependent: :destroy
	has_one :current_player_season, -> { where(current_season: true) }, class_name: 'PlayerSeason', foreign_key: :player_id

	enum position: { :goalkeeper => 'Goalkeeper', :defender => 'Defender', :midfielder => 'Midfielder', :attacker => 'Attacker' }

	def return_name
		short_name.presence || full_name
	end
end
