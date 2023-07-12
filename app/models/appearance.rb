# == Schema Information
#
# Table name: appearances
#
#  id               :bigint           not null, primary key
#  appearance_type  :string
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
#  fk_rails_...  (fixture_id => fixtures.id)
#  fk_rails_...  (player_season_id => player_seasons.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
class Appearance < ApplicationRecord
  belongs_to :team_season
  belongs_to :player_season
  belongs_to :fixture

  has_many :goals
  has_many :cards

  scope :home_starts, ->(fixture) { where(is_home: true, fixture_id: fixture.id, appearance_type: 'start') }
  scope :away_starts, ->(fixture) { where(is_home: nil, fixture_id: fixture.id, appearance_type: 'start') }
  scope :home_subs, ->(fixture) { where(is_home: true, fixture_id: fixture.id, appearance_type: 'substitute') }
  scope :away_subs, ->(fixture) { where(is_home: nil, fixture_id: fixture.id, appearance_type: 'substitute') }

  def create_appearance_for_player(player_id, fixture, team_season, is_home=nil)
    binding.pry
    update(
      player_season: get_player_season(player_id),
      team_season: team_season,
      fixture_id: fixture.id,
      appearance_type: 'start',
      is_home: is_home,
      minute: 90
    )
  end

  def appearance_player_name
    player_season.get_player_name
  end

  def appearance_team_name
    team_season.team_name
  end

  def yellow_cards
    cards.where(card_type: "yellow")
  end

  def red_cards
    cards.where(card_type: "red")
  end

  private

  def get_player_season(player_id)
    Player.find_by(api_football_id: player_id).player_seasons.where(current_season: true).first
  end
end
