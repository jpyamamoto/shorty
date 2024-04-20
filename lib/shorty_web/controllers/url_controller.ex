defmodule ShortyWeb.UrlController do
  use ShortyWeb, :controller

  alias Shorty.Urls
  alias Shorty.Urls.Url

  action_fallback ShortyWeb.FallbackController

  def create(conn, %{"url" => url}) do
    with {:ok, %Url{} = url} <- Urls.create_url(%{"url" => url}) do
      conn
      |> put_status(:created)
      |> render(:create, url: url)
    end
  end
end
