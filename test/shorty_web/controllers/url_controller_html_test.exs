defmodule ShortyWeb.UrlControllerHTMLTest do
  use ShortyWeb.ConnCase

  import Shorty.UrlsFixtures

  describe "homepage" do
    test "GET /", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert html_response(conn, 200) =~ "URL to shorten:"
    end
  end

  describe "correct redirect" do
    test "GET /", %{conn: conn} do
      url = url_fixture()
      conn = get(conn, ~p"/#{url.key}")

      assert html_response(conn, 302) =~ "You are being"
      assert html_response(conn, 302) =~ "redirected"
    end
  end
end
