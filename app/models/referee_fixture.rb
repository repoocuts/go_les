# == Schema Information
#
# Table name: referee_fixtures
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fixture_id :bigint           not null
#  referee_id :bigint           not null
#  season_id  :bigint
#
# Indexes
#
#  index_referee_fixtures_on_fixture_id  (fixture_id)
#  index_referee_fixtures_on_referee_id  (referee_id)
#  index_referee_fixtures_on_season_id   (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (fixture_id => fixtures.id)
#  fk_rails_...  (referee_id => referees.id) ON DELETE => cascade
#  fk_rails_...  (season_id => seasons.id) ON DELETE => cascade
#
class RefereeFixture < ApplicationRecord
	belongs_to :fixture
	belongs_to :referee, dependent: :destroy
	belongs_to :season, optional: true

	has_many :cards
	has_many :goals
end
