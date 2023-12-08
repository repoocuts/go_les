class Avo::Resources::PlayerSeason < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :api_football_id, as: :number
    field :team_season_id, as: :number
    field :player_id, as: :number
    field :current_season, as: :boolean
    field :assists_count, as: :number
    field :goals_count, as: :number
    field :appearances_count, as: :number
    field :player, as: :belongs_to
    field :team_season, as: :belongs_to
    field :appearances, as: :has_many
    field :goals, as: :has_many
    field :cards, as: :has_many
    field :assists, as: :has_many
  end
end
