# == Schema Information
#
# Table name: seasons
#
#  id                :bigint           not null, primary key
#  current_game_week :integer
#  current_season    :boolean
#  end_date          :datetime
#  slug              :string
#  start_date        :datetime
#  years             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  api_football_id   :integer
#  league_id         :bigint           not null
#
# Indexes
#
#  index_seasons_on_league_id  (league_id)
#  index_seasons_on_slug       (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (league_id => leagues.id) ON DELETE => cascade
#
require "test_helper"

class SeasonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
