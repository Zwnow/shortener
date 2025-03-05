defmodule Shortener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :original, :string
      add :shortened, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:urls, [:original, :shortened])
  end
end
