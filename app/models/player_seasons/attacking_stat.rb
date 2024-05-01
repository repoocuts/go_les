# == Schema Information
#
# Table name: attacking_stats
#
#  id                       :bigint           not null, primary key
#  assists_away             :integer          default(0)
#  assists_away_first_half  :integer          default(0)
#  assists_away_second_half :integer          default(0)
#  assists_first_half       :integer          default(0)
#  assists_home             :integer          default(0)
#  assists_home_first_half  :integer          default(0)
#  assists_home_second_half :integer          default(0)
#  assists_second_half      :integer          default(0)
#  assists_total            :integer          default(0)
#  scored_away              :integer          default(0)
#  scored_away_first_half   :integer          default(0)
#  scored_away_second_half  :integer          default(0)
#  scored_first_half        :integer          default(0)
#  scored_home              :integer          default(0)
#  scored_home_first_half   :integer          default(0)
#  scored_home_second_half  :integer          default(0)
#  scored_second_half       :integer          default(0)
#  scored_total             :integer          default(0)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  player_season_id         :bigint           not null
#
# Indexes
#
#  index_attacking_stats_on_player_season_id  (player_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_season_id => player_seasons.id)
#
module PlayerSeasons
	class AttackingStat < ApplicationRecord
		self.table_name = 'attacking_stats'

		belongs_to :player_season
	end
end
