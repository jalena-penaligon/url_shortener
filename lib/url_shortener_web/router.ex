defmodule UrlShortenerWeb.Router do
  use UrlShortenerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UrlShortenerWeb do
    pipe_through :api
    resources "/shorteners", ShortenerController, except: [:new, :edit]
  end

  scope "/", UrlShortenerWeb do
    get "/:short_url", RedirectController, :index
  end
end
