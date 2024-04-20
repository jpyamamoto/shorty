defmodule ShortyWeb.PageController do
  alias Shorty.Urls
  use ShortyWeb, :controller

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
        Task.start(fn -> Urls.increment_visits(url) end)
        redirect(conn, external: url.url)
    end
  end

  def create(conn, %{"url" => url}) do
    {:ok, new_url} = Urls.create_url(%{"url" => url})

    conn
    |> put_flash(:info, "URL shortened successfully")
    |> render(:create, layout: false, data: %{key: "#{ShortyWeb.Endpoint.url()}/#{new_url.key}"})
  end
end
