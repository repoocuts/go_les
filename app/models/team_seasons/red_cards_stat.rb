# == Schema Information
#
# Table name: red_cards_stats
#
#  id               :bigint           not null, primary key
#  away             :integer
#  away_first_half  :integer
#  away_second_half :integer
#  first_half       :integer
#  home             :integer
#  home_first_half  :integer
#  home_second_half :integer
#  second_half      :integer
#  total            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  team_season_id   :bigint           not null
#
# Indexes
#
#  index_red_cards_stats_on_team_season_id  (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_season_id => team_seasons.id) ON DELETE => cascade
#
module TeamSeasons
	class RedCardsStat < ApplicationRecord
		belongs_to :team_season
	end
end
