defmodule ShortyWeb.UrlControllerTest do
  use ShortyWeb.ConnCase

  # import Shorty.UrlsFixtures

  # alias Shorty.Urls.Url

  @create_attrs "https://hexdocs.pm/ecto/Ecto.html"
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create url" do
    test "renders url when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/new", url: @create_attrs)
      assert %{"shortened" => id} = json_response(conn, 201)["data"]

      {:ok, %{path: key}} = URI.new(id)

      conn = get(conn, "/api#{key}")

      assert %{
               "shortened" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/new", url: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  # defp create_url(_) do
  #   url = url_fixture()
  #   %{url: url}
  # end
end
