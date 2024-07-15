# == Schema Information
#
# Table name: referees
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :bigint           not null
#
# Indexes
#
#  index_referees_on_season_id  (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id) ON DELETE => cascade
#
class Referee < ApplicationRecord
	belongs_to :season, optional: true
end
