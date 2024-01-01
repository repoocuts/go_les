# == Schema Information
#
# Table name: goals_conceded_stats
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
#  index_goals_conceded_stats_on_team_season_id  (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_season_id => team_seasons.id)
#
class GoalsConcededStat < ApplicationRecord
	belongs_to :team_season
end
