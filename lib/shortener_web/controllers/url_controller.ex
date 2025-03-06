defmodule ShortenerWeb.UrlController do
  use ShortenerWeb, :controller
  alias Shortener.Urls

  def index(conn, %{"id" => id}) do
    IO.inspect(id)
    case Urls.get_original_url("https://sveno.dev/#{id}") do
      {:ok, url} -> redirect(conn, external: "#{url}")
      {:error, _} -> send_resp(conn, 400, "Not found")
    end
  end

  def shorten(conn, %{"url" => url}) do
    shortened = Urls.create_short_url(url)
    json(conn, %{shortened_url: shortened})
  end
end
