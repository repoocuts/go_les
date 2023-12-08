class Avo::Resources::TeamSeason < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :api_football_id, as: :number
    field :season_id, as: :number
    field :team_id, as: :number
    field :current_season, as: :boolean
    field :points, as: :number
    field :assists_count, as: :number
    field :goals_count, as: :number
    field :appearances_count, as: :number
    field :yellow_cards_count, as: :number
    field :red_cards_count, as: :number
    field :team, as: :belongs_to
    field :season, as: :belongs_to
    field :appearances, as: :has_many
    field :player_seasons, as: :has_many
    field :goals, as: :has_many
    field :cards, as: :has_many
    field :assists, as: :has_many
    field :home_fixtures, as: :has_many
    field :away_fixtures, as: :has_many
    field :yellow_cards, as: :has_many
    field :red_cards, as: :has_many
  end
end
