class PlayerSeason < ApplicationRecord
  belongs_to :team_season
  belongs_to :player
end
