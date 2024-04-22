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

    get "/:key", UrlController, :index
    post "/new", UrlController, :create
    get "/", UrlController, :home
  end

  scope "/api", ShortyWeb do
    pipe_through :api

    post "/new", UrlController, :create
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:shorty, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
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
