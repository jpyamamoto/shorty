defmodule ShortyWeb.UrlController do
  use ShortyWeb, :controller

  alias Shorty.Urls
  alias Shorty.Urls.Url

  action_fallback ShortyWeb.FallbackController

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false, changeset: %{"url" => nil})
  end

  def index(conn, params) do
    %{"key" => key} = params

    case Urls.get_url_by_key(key) do
      nil ->
        conn
        |> put_flash(:error, "Link does not exist")
        |> redirect(to: "/")
      url ->
        Task.start(fn -> Urls.increment_visits_of_key(url.key) end)
        redirect(conn, external: url.url)
    end
  end

  def create(conn, %{"url" => url}) do
    with {:ok, %Url{} = url} <- Urls.create_url(%{"url" => url}) do
      conn
      |> put_status(:created)
      |> render(:create, layout: false, data: url)
    end
  end
end
