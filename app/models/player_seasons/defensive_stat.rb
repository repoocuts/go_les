# == Schema Information
#
# Table name: defensive_stats
#
#  id                           :bigint           not null, primary key
#  clean_sheet_away             :integer          default(0)
#  clean_sheet_away_first_half  :integer          default(0)
#  clean_sheet_away_second_half :integer          default(0)
#  clean_sheet_first_half       :integer          default(0)
#  clean_sheet_home             :integer          default(0)
#  clean_sheet_home_first_half  :integer          default(0)
#  clean_sheet_home_second_half :integer          default(0)
#  clean_sheet_second_half      :integer          default(0)
#  clean_sheet_total            :integer          default(0)
#  conceded_away                :integer          default(0)
#  conceded_away_first_half     :integer          default(0)
#  conceded_away_second_half    :integer          default(0)
#  conceded_first_half          :integer          default(0)
#  conceded_home                :integer          default(0)
#  conceded_home_first_half     :integer          default(0)
#  conceded_home_second_half    :integer          default(0)
#  conceded_second_half         :integer          default(0)
#  conceded_total               :integer          default(0)
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
