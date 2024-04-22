defmodule ShortyWeb.Router do
  use ShortyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ShortyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShortyWeb do
    pipe_through :browser

    post "/new", UrlController, :create
    get "/:key", UrlController, :access
    get "/", UrlController, :home
  end

  scope "/api", ShortyWeb do
    pipe_through :api

    post "/new", UrlController, :create
    get "/:key", UrlController, :index
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:shorty, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev", ShortyWeb do
      pipe_through :browser

      live "/urls", UrlLive.Index, :index
      live "/urls/new", UrlLive.Index, :new
      live "/urls/:id/edit", UrlLive.Index, :edit

      live "/urls/:id", UrlLive.Show, :show
      live "/urls/:id/show/edit", UrlLive.Show, :edit

      live_dashboard "/dashboard", metrics: ShortyWeb.Telemetry
    end
  end
end
