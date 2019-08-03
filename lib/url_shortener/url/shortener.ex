defmodule UrlShortener.Url.Shortener do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shorteners" do
    field :long_url, :string
    field :short_url, :string

    timestamps()
  end

  @doc false
  def changeset(shortener, attrs) do
    shortener
    |> cast(attrs, [:long_url, :short_url])
    |> validate_required([:long_url, :short_url])
    |> unique_constraint(:long_url)
    |> unique_constraint(:short_url)
  end
end
