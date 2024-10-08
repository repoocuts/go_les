# == Schema Information
#
# Table name: goals
#
#  id                 :bigint           not null, primary key
#  goal_type          :string
#  is_home            :boolean
#  minute             :integer
#  own_goal           :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  appearance_id      :bigint           not null
#  assist_id          :integer
#  fixture_id         :bigint           not null
#  player_season_id   :bigint           not null
#  referee_fixture_id :integer
#  team_season_id     :bigint           not null
#
# Indexes
#
#  index_goals_on_appearance_id     (appearance_id)
#  index_goals_on_assist_id         (assist_id)
#  index_goals_on_fixture_id        (fixture_id)
#  index_goals_on_goal_type         (goal_type)
#  index_goals_on_player_season_id  (player_season_id)
#  index_goals_on_team_season_id    (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (appearance_id => appearances.id) ON DELETE => cascade
#  fk_rails_...  (fixture_id => fixtures.id) ON DELETE => cascade
#  fk_rails_...  (player_season_id => player_seasons.id) ON DELETE => cascade
#  fk_rails_...  (team_season_id => team_seasons.id) ON DELETE => cascade
#
class Goal < ApplicationRecord
	belongs_to :appearance, counter_cache: true
	belongs_to :player_season, counter_cache: true
	belongs_to :team_season, counter_cache: true
	belongs_to :fixture
	belongs_to :referee_fixture, optional: true

	has_one :assist

	scope :home_goals, -> { where(is_home: true) }
	scope :away_goals, -> { where(is_home: nil) }
	scope :fixture_home_goals, ->(fixture) { where(is_home: true, fixture_id: fixture.id).order(:minute) }
	scope :fixture_away_goals, ->(fixture) { where(is_home: nil, fixture_id: fixture.id).order(:minute) }
	scope :group_by_player_season, -> { group(:player_season_id) }
	scope :first_half, -> { where('minute < ?', 46) }
	scope :second_half, -> { where('minute > ?', 45) }
	scope :by_season, -> (season_id) {
		select('player_season_id, count(goals.id) as goal_count')
			.joins(:team_season)
			.includes(:player_season)
			.where('team_seasons.season_id = ?', season_id)
			.group(:player_season_id)
			.order('count(goals.id) DESC')
	}
	scope :for_team_season, ->(team_season_id) {
		where(team_season_id: team_season_id)
	}
end
