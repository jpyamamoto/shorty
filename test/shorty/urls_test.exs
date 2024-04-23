defmodule Shorty.UrlsTest do
  alias Shorty.Cache
  use Shorty.DataCase

  alias Shorty.Urls

  @non_existent_id 10_000
  @non_existent_key "key"

  describe "urls" do
    alias Shorty.Urls.Url

    import Shorty.UrlsFixtures

    @invalid_attrs %{key: nil, url: nil, visits: nil}

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Urls.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Urls.get_url!(url.id) == url
    end

    test "get_url/1 returns the url with given id or nil" do
      url = url_fixture()

      assert Urls.get_url(url.id) == url
      assert Urls.get_url(@non_existent_id) == nil
    end

    test "get_url_by_key/1 returns the url with the given key" do
      url = url_fixture()

      assert Urls.get_url_by_key(url.key, true) == url
      assert Urls.get_url_by_key(@non_existent_key, true) == nil
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{url: "https://www.phoenixframework.org/"}

      assert {:ok, %Url{} = url} = Urls.create_url(valid_attrs)
      assert url.key != ""
      assert url.url == "https://www.phoenixframework.org/"
      assert url.visits == 0
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Urls.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      update_attrs = %{key: "oayQyeU", url: "https://elixir-lang.org/", visits: 43}

      assert {:ok, %Url{} = url} = Urls.update_url(url, update_attrs)
      assert url.key == "oayQyeU"
      assert url.url == "https://elixir-lang.org/"
      assert url.visits == 43
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Urls.update_url(url, @invalid_attrs)
      assert url == Urls.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = Urls.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Urls.get_url!(url.id) end
     end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Urls.change_url(url)
    end
  end

  describe "cache usage" do
    alias Shorty.Urls.Url

    import Shorty.UrlsFixtures

    test "get_url_by_key/1 works independently of cache" do
      url = url_fixture()

      assert Cache.get_url(url.key) == nil

      retrieved_url_1 = Urls.get_url_by_key(url.key)
      retrieved_url_2 = Urls.get_url_by_key(url.key)

      assert retrieved_url_1 == url

      assert retrieved_url_1.key == retrieved_url_2.key
      assert retrieved_url_1.url == retrieved_url_2.url
    end

    test "cache is being populated through get_url_by_key/1" do
      url = url_fixture()

      assert Cache.get_url(url.key) == nil

      retrieved_url = Urls.get_url_by_key(url.key)
      cached_url = Cache.get_url(url.key)

      assert retrieved_url.key == cached_url.key
      assert retrieved_url.url == cached_url.url
    end
  end
end
