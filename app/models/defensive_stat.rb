# == Schema Information
#
# Table name: defensive_stats
#
#  id                           :bigint           not null, primary key
#  clean_sheet_away             :integer
#  clean_sheet_away_first_half  :integer
#  clean_sheet_away_second_half :integer
#  clean_sheet_first_half       :integer
#  clean_sheet_home             :integer
#  clean_sheet_home_first_half  :integer
#  clean_sheet_home_second_half :integer
#  clean_sheet_second_half      :integer
#  clean_sheet_total            :integer
#  conceded_away                :integer
#  conceded_away_first_half     :integer
#  conceded_away_second_half    :integer
#  conceded_first_half          :integer
#  conceded_home                :integer
#  conceded_home_first_half     :integer
#  conceded_home_second_half    :integer
#  conceded_second_half         :integer
#  conceded_total               :integer
#  player_season_id             :bigint           not null
#
# Indexes
#
#  index_defensive_stats_on_player_season_id  (player_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_season_id => player_seasons.id)
#
module PlayerSeasons
	class DefensiveStat < ApplicationRecord
		self.table_name = 'defensive_stats'

		belongs_to :player_season
	end
end
