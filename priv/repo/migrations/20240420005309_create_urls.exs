defmodule Shorty.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :key, :string, null: false
      add :url, :text, null: false
      add :visits, :integer, default: 0

      timestamps(type: :utc_datetime)
    end

    create unique_index(:urls, :key)
  end
end
