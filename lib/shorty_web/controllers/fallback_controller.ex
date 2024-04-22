defmodule ShortyWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  alias Ecto
  use ShortyWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: ShortyWeb.ErrorHTML, json: ShortyWeb.ChangesetJSON)
    |> render(:"404")
  end
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(html: ShortyWeb.ErrorHTML, json: ShortyWeb.ChangesetJSON)
    |> render("error.json", changeset: changeset)
  end
end
