defmodule Shorty.Cache do
  use GenServer

  alias Shorty.Urls.Url

  @name_table :urls_cache

  @doc """
  Start the caching service.
  """
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @doc """
  Retrieve a URL from the cache.

  This will yield a `Url` struct, but only the `key` and `url` will be provided.

  If the key is not cached, return `nil`.
  """
  def get_url(key) do
    case :ets.lookup(@name_table, key) do
      [] -> nil
      [{^key, url} | _] -> %Url{ key: key, url: url }
    end
  end

  @doc """
  Insert a `Url` to the cache.

  Returns the same `Url` struct, so it can be run in a pipeline
  without altering the result.
  """
  def insert_url(%Url{} = url) do
    :ets.insert(@name_table, {url.key, url.url})
    url
  end

  # Callbacks
  @impl(GenServer)
  def init(state) do
    :ets.new(@name_table, [:set, :public, :named_table, read_concurrency: true])
    {:ok, state}
  end
end
