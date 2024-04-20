defmodule ShortyWeb.UrlLive.Index do
  use ShortyWeb, :live_view

  alias Shorty.Urls
  alias Shorty.Urls.Url

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :urls, Urls.list_urls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Url")
    |> assign(:url, Urls.get_url!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Url")
    |> assign(:url, %Url{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Urls")
    |> assign(:url, nil)
  end

  @impl true
  def handle_info({ShortyWeb.UrlLive.FormComponent, {:saved, url}}, socket) do
    {:noreply, stream_insert(socket, :urls, url)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    url = Urls.get_url!(id)
    {:ok, _} = Urls.delete_url(url)

    {:noreply, stream_delete(socket, :urls, url)}
  end
end
