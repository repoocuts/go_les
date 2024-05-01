# == Schema Information
#
# Table name: discipline_stats
#
#  id                           :bigint           not null, primary key
#  red_card_away                :integer
#  red_card_away_first_half     :integer
#  red_card_away_second_half    :integer
#  red_card_first_half          :integer
#  red_card_home                :integer
#  red_card_home_first_half     :integer
#  red_card_home_second_half    :integer
#  red_card_second_half         :integer
#  red_card_total               :integer
#  yellow_card_away             :integer
#  yellow_card_away_first_half  :integer
#  yellow_card_away_second_half :integer
#  yellow_card_first_half       :integer
#  yellow_card_home             :integer
#  yellow_card_home_first_half  :integer
#  yellow_card_home_second_half :integer
#  yellow_card_second_half      :integer
#  yellow_card_total            :integer
#  player_season_id             :bigint           not null
#
# Indexes
#
#  index_discipline_stats_on_player_season_id  (player_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_season_id => player_seasons.id)
#
module PlayerSeasons
	class DisciplineStat < ApplicationRecord
		self.table_name = 'discipline_stats'

		belongs_to :player_season
	end
end
