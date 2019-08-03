defmodule UrlShortenerWeb.ShortenerView do
  use UrlShortenerWeb, :view
  alias UrlShortenerWeb.ShortenerView

  def render("index.json", %{shorteners: shorteners}) do
    %{data: render_many(shorteners, ShortenerView, "shortener.json")}
  end

  def render("show.json", %{shortener: shortener}) do
    %{data: render_one(shortener, ShortenerView, "shortener.json")}
  end

  def render("shortener.json", %{shortener: shortener}) do
    %{id: shortener.id,
      long_url: shortener.long_url,
      short_url: shortener.short_url}
  end
end
