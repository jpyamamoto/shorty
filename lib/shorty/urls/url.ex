defmodule Shorty.Urls.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :key, :string
    field :url, :string
    field :visits, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:key, :url, :visits])
    |> validate_required([:url])
    |> unique_constraint(:key)
  end
end
