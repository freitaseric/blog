defmodule Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :content, :string
    field :published_at, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published_at])
    |> validate_required([:title, :content])
    |> validate_length(:title, min: 3, max: 200)
  end
end
