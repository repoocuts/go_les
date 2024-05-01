# == Schema Information
#
# Table name: players
#
#  id              :bigint           not null, primary key
#  full_name       :string
#  position        :string
#  short_name      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  team_id         :bigint           not null
#
# Indexes
#
#  index_players_on_full_name   (full_name)
#  index_players_on_short_name  (short_name)
#  index_players_on_team_id     (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class Player < ApplicationRecord
	belongs_to :team
	has_many :player_seasons

	enum position: { :goalkeeper => 'Goalkeeper', :defender => 'Defender', :midfielder => 'Midfielder', :attacker => 'Attacker' }

	def current_player_season
		player_seasons.find_by(current_season: true) || player_seasons.first
	end

	def return_name
		short_name.presence || full_name
	end
end
