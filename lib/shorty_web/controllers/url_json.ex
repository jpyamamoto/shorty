defmodule ShortyWeb.UrlJSON do
  alias Shorty.Urls.Url

  @doc """
  Renders a single url as a JSON.
  """
  def index(data), do: encode(data)

  @doc """
  Renders a newly created single url as a JSON.
  """
  def create(data), do: encode(data)

  defp encode(%{data: url}) do
    %{data: data(url)}
  end

  defp data(%Url{} = url) do
    %{
      shortened: "#{ShortyWeb.Endpoint.url()}/#{url.key}",
      url: url.url,
      visits: url.visits,
    }
  end
end
