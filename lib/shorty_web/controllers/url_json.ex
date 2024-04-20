defmodule ShortyWeb.UrlJSON do
  alias Shorty.Urls.Url

  @doc """
  Renders a single url as a JSON.
  """
  def create(%{url: url}) do
    %{data: data(url)}
  end

  defp data(%Url{} = url) do
    %{
      shortened: "#{ShortyWeb.Endpoint.url()}/#{url.key}",
      url: url.url,
    }
  end
end
