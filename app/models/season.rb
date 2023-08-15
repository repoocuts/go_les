# == Schema Information
#
# Table name: seasons
#
#  id                :bigint           not null, primary key
#  current_game_week :integer
#  current_season    :boolean
#  end_date          :datetime
#  start_date        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  api_football_id   :integer
#  league_id         :bigint           not null
#
# Indexes
#
#  index_seasons_on_league_id  (league_id)
#
# Foreign Keys
#
#  fk_rails_...  (league_id => leagues.id)
#
class Season < ApplicationRecord
  belongs_to :league
  has_many :fixtures
  has_many :team_seasons
  has_many :player_seasons, through: :team_seasons
  has_many :goals, through: :team_seasons
  
  scope :current_season, -> { find_by(current_season: true) }

  def next_round_of_fixtures
    fixtures.where(season_id: id, game_week: game_week + 1)
  end

  def completed_fixtures
    fixtures.where('kick_off < ? AND (SELECT COUNT(*) FROM appearances WHERE appearances.fixture_id = fixtures.id) = ?', DateTime.now, 0)
  end
end
