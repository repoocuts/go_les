# == Schema Information
#
# Table name: team_seasons
#
#  id              :bigint           not null, primary key
#  current_season  :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  season_id       :bigint           not null
#  team_id         :bigint           not null
#
# Indexes
#
#  index_team_seasons_on_season_id  (season_id)
#  index_team_seasons_on_team_id    (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#  fk_rails_...  (team_id => teams.id)
#
class TeamSeason < ApplicationRecord
  belongs_to :team
  belongs_to :season
  has_many :appearances
  has_many :player_seasons
  has_many :goals
  has_many :cards

  def team_name
    team.name
  end

  def next_match
    Fixture.find_by("game_week = ? AND (home_team_season_id = ? OR away_team_season_id = ?)", season.current_game_week + 1, id, id)
  end

  def next_match_opponent_name
    return next_match.home_team_name if team.name == next_match.away_team_name

    next_match.away_team_name
  end

  def last_match
    Fixture.find_by("game_week = ? AND (home_team_season_id = ? OR away_team_season_id = ?)", season.current_game_week, id, id)
  end

  def last_match_opponent_name
    return last_match.home_team_name if team.name == last_match.away_team_name

    last_match.away_team_name
  end

  def last_match_result
    if last_match.home_team_season_id == id
      "#{last_match.home_score} - #{last_match.away_score}"
    else
      "#{last_match.home_score} - #{last_match.away_score}"
    end
  end

  def last_match_details_string
    home_or_away_string(last_match).to_s + ' ' + last_match_opponent_name.to_s
  end

  def top_scorer
    player_seasons.map { |ps| [ps.season_goals, ps.player.full_name, ps.player_id] }.sort! { |a,b| a.first <=> b.first }.reverse
  end

  def booked_players
    player_seasons.booked_players
  end

  def sent_off_players
    player_seasons.sent_off_players
  end

  def most_booked_player
    player_seasons.booked_players.first
  end

  def most_reds_player
    player_seasons.sent_off_players.first
  end

  def home_or_away_string(match)
    return "(H)" if match.home_team_season_id == id

    "(A)"
  end

  def all_fixtures_sorted_by_game_week
    Fixture.where("season_id = ? AND (home_team_season_id = ? OR away_team_season_id = ?)", season_id, id, id).order(:game_week)
  end

  def completed_fixtures
    all_fixtures_sorted_by_game_week.where.not(home_score: nil)
  end

  def upcoming_fixtures
    all_fixtures_sorted_by_game_week.where(home_score: nil)
  end

  def completed_fixtures_reversed
    all_fixtures_sorted_by_game_week.where.not(home_score: nil).reverse
  end

  def upcoming_fixtures_reversed
    all_fixtures_sorted_by_game_week.where(home_score: nil).reverse
  end

  def match_opponent_name(match)
    return match.home_team_name if team.name == match.away_team_name

    match.away_team_name
  end

  def last_five_matches
    completed_fixtures.last(5)
  end

  def last_five_results
    last_five_matches.map do |match|
      results_formatter(match)
    end.flatten
  end

  def played_home_matches
    Fixture.where(id: completed_fixtures_reversed(&:id)).where(home_team_season_id: id)
  end

  def played_away_matches
    Fixture.where(id: completed_fixtures_reversed(&:id)).where(away_team_season_id: id)
  end

  def goals_for
    goals
  end

  def goals_against
    Goal.where.not(team_season_id: id, fixture_id: completed_fixtures.pluck(:id))
  end

  def top_scorers
    player_seasons.scorers.first(3)
  end

  def average_first_half_goals
    (first_half_goals.count / completed_fixtures.count.to_f).round(2)
  end

  def average_second_half_goals
    (second_half_goals.count / completed_fixtures.count.to_f).round(2)
  end

  def average_goals_scored_per_match
    (goals.count.to_f / completed_fixtures.count.to_f).round(2)
  end

  def average_goals_conceeded_per_match
    (goals_against.count.to_f / completed_fixtures.count).round(2)
  end

  def home_goals_conceeded
    goals_against.where('is_home = ?', true)
  end

  def away_goals_conceeded
    goals_against.where('is_home = ?', false)
  end

  def home_goals_conceeded_count
    goals_against.where('is_home = ?', true).count
  end

  def away_goals_conceeded_count
    goals_against.where('is_home = ?', false).count
  end

  def average_goals_conceeded_home
    (home_goals_conceeded_count / completed_fixtures.count.to_f).round(2)
  end

  def average_goals_conceeded_away
    (away_goals_conceeded_count / completed_fixtures.count.to_f).round(2)
  end

  def average_goals_scored_first_half
    (goals.count.to_f / completed_fixtures.count).round(2)
  end

  def average_goals_scored_second_half
    (goals.count.to_f / completed_fixtures.count).round(2)
  end

  def average_goals_scored_at_home
    (goals.count.to_f / completed_fixtures.count).round(2)
  end

  def average_goals_scored_at_away
    (goals.count.to_f / completed_fixtures.count).round(2)
  end

  def average_first_half_goals_conceeded_home
    (home_goals_conceeded.where('minute < ?', 46).count / completed_fixtures.count.to_f.round(2))
  end

  def average_first_half_goals_conceeded_away
    (away_goals_conceeded.where('minute < ?', 46).count / completed_fixtures.count.to_f.round(2))
  end

  def average_second_half_goals_conceeded_home
    (home_goals_conceeded.where('minute > ?', 46).count / completed_fixtures.count.to_f.round(2))
  end

  def average_second_half_goals_conceeded_away
    (away_goals_conceeded.where('minute > ?', 46).count / completed_fixtures.count.to_f.round(2))
  end

  def first_half_home_goals_conceeded
    home_goals_conceeded.where('minute < ?', 46).count
  end

  def second_half_home_goals_conceeded
    home_goals_conceeded.where('minute > ?', 45).count
  end

  def first_half_away_goals_conceeded
    away_goals_conceeded.where('minute < ?', 46).count
  end

  def second_half_away_goals_conceeded
    away_goals_conceeded.where('minute > ?', 45).count
  end

  def first_half_goals
    goals.first_half_goals
  end

  def second_half_goals
    goals.second_half_goals
  end

  private

  def results_formatter(match, array: [])
    if match.home_score.nil?
      array.push('-')
    else
      if match.home_team_season_id == self.id
        if match.home_score > match.away_score
          array.push('W')
        elsif match.home_score == match.away_score
          array.push('D')
        else
          array.push('L')
        end
      else
        if match.away_score > match.home_score
          array.push('W')
        elsif match.home_score == match.away_score
          array.push('D')
        else
          array.push('L')
        end
      end
    end
    array
  end
end
