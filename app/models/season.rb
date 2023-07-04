class Season < ApplicationRecord
  belongs_to :league
  has_many :fixtures
  has_many :team_seasons
  has_many :player_seasons
  
  def next_round_of_fixtures
    fixtures.where(season_id: id, game_week: game_week + 1)
  end
end
