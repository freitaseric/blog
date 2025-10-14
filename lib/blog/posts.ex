defmodule Blog.Posts do
  import Ecto.Query
  alias Blog.Repo
  alias Blog.Post

  def list_posts do
    Post
    |> where([p], not is_nil(p.published_at))
    |> order_by([p], desc: p.published_at)
    |> Repo.all()
  end

  def list_all_posts do
    Post
    |> order_by([p], desc: p.published_at)
    |> Repo.all()
  end

  def get_post!(id) do
    Repo.get!(Post, id)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def publish_post(%Post{} = post) do
    post
    |> Post.changeset(%{published_at: NaiveDateTime.utc_now()})
    |> Repo.update()
  end
end
