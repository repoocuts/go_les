class Player < ApplicationRecord
  belongs_to :team
  has_many :player_seasons

  def current_player_season
    player_seasons.where(current_season: true).first
  end

  def return_name
    return short_name if full_name.nil?

    full_name
  end
end
