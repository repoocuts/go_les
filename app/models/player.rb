
# == Schema Information
#
# Table name: players
#
#  id              :bigint           not null, primary key
#  full_name       :string
#  position        :integer
#  short_name      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  team_id         :bigint           not null
#
# Indexes
#
#  index_players_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class Player < ApplicationRecord
  belongs_to :team
  has_many :player_seasons

  enum position: { goalkeeper: 'G', defender: 'D', midfielder: 'M', attacker: 'F' }

  def current_player_season
    player_seasons.where(current_season: true).first || player_seasons.first
  end

  def return_name
    return short_name if full_name.nil?

    full_name
  end
end
