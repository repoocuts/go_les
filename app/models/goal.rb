# == Schema Information
#
# Table name: goals
#
#  id               :bigint           not null, primary key
#  goal_type        :string
#  is_home          :boolean
#  minute           :integer
#  own_goal         :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  appearance_id    :bigint           not null
#  fixture_id       :bigint           not null
#  player_season_id :bigint           not null
#  team_season_id   :bigint           not null
#
# Indexes
#
#  index_goals_on_appearance_id     (appearance_id)
#  index_goals_on_fixture_id        (fixture_id)
#  index_goals_on_player_season_id  (player_season_id)
#  index_goals_on_team_season_id    (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (appearance_id => appearances.id)
#  fk_rails_...  (fixture_id => fixtures.id)
#  fk_rails_...  (player_season_id => player_seasons.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
class Goal < ApplicationRecord
	belongs_to :appearance
	belongs_to :player_season
	belongs_to :team_season
	belongs_to :fixture

	has_one :assist

	scope :home_goals, ->(fixture) { where(is_home: true, fixture_id: fixture.id).order(:minute) }
	scope :away_goals, ->(fixture) { where(is_home: nil, fixture_id: fixture.id).order(:minute) }
	scope :group_by_player_season, -> { group(:player_season_id) }
	scope :first_half_goals, ->(team_season_id) { where('minute < ? AND team_season_id = ?', 46, team_season_id) }
	scope :second_half_goals, ->(team_season_id) { where('minute > ? AND team_season_id = ?', 45, team_season_id) }
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

	def goal_scorer_name
		player_season.get_player_name
	end

	def goal_team_name
		team_season.team_name
	end
end
