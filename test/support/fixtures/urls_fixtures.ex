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
        key: "some key",
        url: "some url",
        visits: 42
      })
      |> Shorty.Urls.create_url()

    url
  end
end
