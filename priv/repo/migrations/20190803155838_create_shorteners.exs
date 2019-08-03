defmodule UrlShortener.Repo.Migrations.CreateShorteners do
  use Ecto.Migration

  def change do
    create table(:shorteners) do
      add :long_url, :string
      add :short_url, :string

      timestamps()
    end

    create unique_index(:shorteners, [:long_url])
    create unique_index(:shorteners, [:short_url])
  end
end
