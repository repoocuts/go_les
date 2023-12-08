class Avo::Resources::Appearance < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :minutes, as: :number
    field :appearance_type, as: :text
    field :is_home, as: :boolean
    field :player_season_id, as: :number
    field :team_season_id, as: :number
    field :fixture_id, as: :number
    field :goals_count, as: :number
    field :assists_count, as: :number
    field :team_season, as: :belongs_to
    field :player_season, as: :belongs_to
    field :fixture, as: :belongs_to
    field :goals, as: :has_many
    field :cards, as: :has_many
    field :assists, as: :has_many
  end
end
