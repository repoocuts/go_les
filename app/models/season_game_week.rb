# == Schema Information
#
# Table name: season_game_weeks
#
#  id               :bigint           not null, primary key
#  game_week_number :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fixture_id       :bigint
#  season_id        :bigint
#
# Indexes
#
#  index_season_game_weeks_on_fixture_id  (fixture_id)
#  index_season_game_weeks_on_season_id   (season_id)
#
class SeasonGameWeek < ApplicationRecord
	belongs_to :season
	has_many :fixtures

	# Fixture.all.group_by(&:game_week).sort.each do |gw, fixtures|
	# 	sgw = SeasonGameWeek.create(season: season, game_week: gw)
	# 	fixtures.each do |f|
	# 		f.update(season_game_week: sgw)
	# 	end
	# end

end
