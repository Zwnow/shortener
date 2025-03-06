defmodule Shortener.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :original, :text
    field :shortened, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:original, :shortened])
    |> validate_required([:original, :shortened])
  end
end
