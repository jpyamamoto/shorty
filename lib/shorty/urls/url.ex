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
    |> validate_url()
  end

  defp validate_url(changeset) do
    url_field = get_field(changeset, :url)

    case URI.new(url_field) do
      {:ok, url}->
        if url.scheme != nil and url.host != nil do
          changeset
        else
          add_error(changeset, :url, "Not a valid URL")
        end
      {:error, _} ->
          add_error(changeset, :url, "Not a valid URL")
    end
  end
end
