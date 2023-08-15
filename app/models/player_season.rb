# == Schema Information
#
# Table name: player_seasons
#
#  id              :bigint           not null, primary key
#  current_season  :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  player_id       :bigint           not null
#  team_season_id  :bigint           not null
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

  scope :scorers, -> { joins(:goals).reverse }
  scope :booked_players, -> { joins(:cards).where('cards.card_type = ?', "yellow") }
  scope :sent_off_players, -> { joins(:cards).where('cards.card_type = ?', "red") }

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
    goals.count
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
end
