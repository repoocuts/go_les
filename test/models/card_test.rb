# == Schema Information
#
# Table name: cards
#
#  id                 :bigint           not null, primary key
#  card_type          :string
#  is_home            :boolean
#  minute             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  appearance_id      :bigint           not null
#  first_card_id      :integer
#  fixture_id         :bigint           not null
#  player_season_id   :bigint           not null
#  referee_fixture_id :integer
#  team_season_id     :bigint           not null
#
# Indexes
#
#  index_cards_on_appearance_id     (appearance_id)
#  index_cards_on_card_type         (card_type)
#  index_cards_on_fixture_id        (fixture_id)
#  index_cards_on_player_season_id  (player_season_id)
#  index_cards_on_team_season_id    (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (appearance_id => appearances.id)
#  fk_rails_...  (fixture_id => fixtures.id)
#  fk_rails_...  (player_season_id => player_seasons.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
require "test_helper"

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
