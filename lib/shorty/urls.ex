defmodule Shorty.Urls do
  @moduledoc """
  The Urls context.
  """

  import Ecto.Query, warn: false
  alias Shorty.Cache
  alias Shorty.Repo

  alias Shorty.Urls.Url

  @num_bytes 5

  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%Url{}, ...]

  """
  def list_urls do
    Repo.all(Url)
  end

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %Url{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(Url, id)

  def get_url(id), do: Repo.get(Url, id)

  def get_url_by_key(key, bypass_cache \\ false)
  def get_url_by_key(key, true), do: Repo.get_by(Url, key: key)
  def get_url_by_key(key, false) do
    case Cache.get_url key do
      nil ->
        url = Repo.get_by(Url, key: key)

        if url != nil do
          Cache.insert_url url
        else
          url
        end

      url -> url
    end
  end

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %Url{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    attrs = set_random_key(attrs)
    new_url = Url.changeset(%Url{}, attrs)

    case Repo.insert(new_url) do
      {:error, wrong_url} ->
        if Enum.any?(wrong_url.errors,
              fn {_, {_, errors}} -> Keyword.get(errors, :constraint) == :unique end) do
          create_url(attrs)
        else
          {:error, wrong_url}
        end
      {:ok, url} -> {:ok, url}
    end
  end

  @doc """
  Updates a url.

  ## Examples

      iex> update_url(url, %{field: new_value})
      {:ok, %Url{}}

      iex> update_url(url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_url(%Url{} = url, attrs) do
    url
    |> Url.changeset(attrs)
    |> Repo.update()
  end

  def increment_visits_of_key(key) do
    url = get_url_by_key(key, true)

    if url != nil do
      update_url(url, %{ visits: url.visits + 1 })
    end
  end

  @doc """
  Deletes a url.

  ## Examples

      iex> delete_url(url)
      {:ok, %Url{}}

      iex> delete_url(url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_url(%Url{} = url) do
    Repo.delete(url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.

  ## Examples

      iex> change_url(url)
      %Ecto.Changeset{data: %Url{}}

  """
  def change_url(%Url{} = url, attrs \\ %{}) do
    Url.changeset(url, attrs)
  end

  defp set_random_key(url_attrs) do
    Map.put(url_attrs, "key", create_random_key(@num_bytes))
  end

  defp create_random_key(num_bytes) when is_number(num_bytes) and num_bytes > 0 do
    num_bytes
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64(padding: false)
  end
end
