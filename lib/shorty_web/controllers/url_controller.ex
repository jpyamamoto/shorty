defmodule ShortyWeb.UrlController do
  use ShortyWeb, :controller

  alias Shorty.Urls
  alias Shorty.Urls.Url

  action_fallback ShortyWeb.FallbackController

  @doc """
  Home page of the website when accessed from the browser.
  """
  def home(conn, _params) do
    render(conn, :home, layout: false, changeset: %{"url" => nil})
  end

  @doc """
  Try to perform a redirection given a URL, or return to
  the homepage with an error.
  """
  def access(conn, params) do
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

  def index(conn, params) do
    %{"key" => key} = params

    case Urls.get_url_by_key(key, true) do
      nil ->
        {:error, :not_found}

      url ->
        render(conn, :index, data: url)
    end
  end

  @doc """
  Shorten a given URL.
  """
  def create(conn, %{"url" => url}) do
    with {:ok, %Url{} = url} <- Urls.create_url(%{url: url}) do
      conn
      |> put_status(:created)
      |> render(:create, layout: false, data: url)
    end
  end
end
