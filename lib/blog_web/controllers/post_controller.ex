defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  alias Blog.Posts
  alias Blog.Post

  def index(conn, _params) do
    posts = Posts.list_all_posts()
    render(conn, :index, posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post criado com sucesso!")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, :show, post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    changeset = Post.changeset(post, %{})
    render(conn, :edit, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post atualizado!")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, changeset} ->
        render(conn, :edit, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deletado!")
    |> redirect(to: ~p"/posts")
  end
end
