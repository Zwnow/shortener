defmodule Shortener.Urls do
  import Ecto.Query, warn: false
  alias Shortener.Repo
  alias Shortener.Url

  def create_short_url(url) do
    case Repo.one(from u in Url,
      where: u.original == ^url) do
      nil ->
        "https://zwnow.github.io/shortener/#{Ecto.UUID.generate()}"
        |> persist(url)
      url -> url.shortened
    end
  end

  defp persist(shortened, original) do
    change_url(%Url{original: original, shortened: shortened})
    |> Repo.insert()

    shortened
  end

  def get_original_url(short) do
    case Repo.one(from u in Url,
      where: u.shortened == ^short) do
      nil -> {:error, "Not found"}
      url -> {:ok, url.original}
    end
  end

  defp change_url(%Url{} = url, attrs \\ %{}) do
    Url.changeset(url, attrs)
  end
end
