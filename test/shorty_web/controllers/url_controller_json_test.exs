defmodule ShortyWeb.UrlControllerJSONJSONTest do
  use ShortyWeb.ConnCase

  import Shorty.UrlsFixtures

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

  describe "retrieve url information" do
    test "renders correct url data", %{conn: conn} do
      url = url_fixture()
      conn = get(conn, "/api/#{url.key}")

      assert %{"shortened" => shortened, "url" => original_url} = json_response(conn, 200)["data"]

      <<?/, key::binary>> = URI.new!(shortened).path

      assert url.key == key
      assert url.url == original_url
    end
  end
end
