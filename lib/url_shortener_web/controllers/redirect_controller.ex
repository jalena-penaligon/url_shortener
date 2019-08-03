defmodule UrlShortenerWeb.RedirectController do
  use UrlShortenerWeb, :controller
  alias UrlShortener.Repo
  alias UrlShortener.Url.Shortener

  action_fallback UrlShortenerWeb.FallbackController

  def index(conn, %{"short_url" => url_params }) do
    url = Repo.get_by(Shortener, short_url: url_params)
    redirect(conn, external: url.long_url)
  end
end
