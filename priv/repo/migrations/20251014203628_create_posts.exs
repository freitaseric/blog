defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :content, :text, null: false
      add :published_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:posts, [:published_at])
  end
end
