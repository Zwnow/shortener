defmodule ShortenerWeb.Router do
  use ShortenerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShortenerWeb do
    pipe_through :api

    get "/:id", UrlController, :index
    post "/shorten", UrlController, :shorten
  end
end
