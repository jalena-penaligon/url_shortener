defmodule UrlShortenerWeb.ShortenerController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Url
  alias UrlShortener.Url.Shortener

  action_fallback UrlShortenerWeb.FallbackController

  def index(conn, _params) do
    shorteners = Url.list_shorteners()
    render(conn, "index.json", shorteners: shorteners)
  end

  def create(conn, %{"shortener" => shortener_params}) do
    with {:ok, %Shortener{} = shortener} <- Url.create_shortener(shortener_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.shortener_path(conn, :show, shortener))
      |> render("show.json", shortener: shortener)
    end
  end

  def show(conn, %{"id" => id}) do
    shortener = Url.get_shortener!(id)
    render(conn, "show.json", shortener: shortener)
  end

  def update(conn, %{"id" => id, "shortener" => shortener_params}) do
    shortener = Url.get_shortener!(id)

    with {:ok, %Shortener{} = shortener} <- Url.update_shortener(shortener, shortener_params) do
      render(conn, "show.json", shortener: shortener)
    end
  end

  def delete(conn, %{"id" => id}) do
    shortener = Url.get_shortener!(id)

    with {:ok, %Shortener{}} <- Url.delete_shortener(shortener) do
      send_resp(conn, :no_content, "")
    end
  end
end
