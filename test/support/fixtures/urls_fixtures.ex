defmodule Shorty.UrlsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shorty.Urls` context.
  """

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        key: "0dWxHh4",
        url: "https://google.com/",
        visits: 42
      })
      |> Shorty.Urls.create_url()

    url
  end
end
