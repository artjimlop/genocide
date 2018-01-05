defmodule Genocide.UserController do
  use Genocide.Web, :controller

  alias Genocide.{User, Repo, ErrorView}
  alias Plug.Conn

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => uuid}) do
    with user = %User{} <- Repo.get(User, uuid) do
      render(conn, "show.json", user: user)
    else
      nil ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", error: "Not found")
    end
  end

  def create(conn, %{"user" => user} = params) do
    changeset = User.changeset(%User{}, user)

      with {:ok, user_to_return} <- Repo.insert(changeset) do
          conn
          |> Conn.put_status(201)
          |> render("show.json", user: user_to_return)
      else
        {:error, %{errors: errors}} ->
          conn
          |> put_status(422)
          |> render(ErrorView, "422.json", %{errors: errors})
        end

    end

  def update(conn, %{"id" => uuid, "user" => user} = params) do
    old_user = Repo.get(User, uuid)
    changeset = User.changeset(old_user, user)
    case Repo.update(changeset) do
      {:ok, updated} ->
        conn
        |> Conn.put_status(201)
        |> render("show.json", user: updated)
        {:error, %{errors: errors}} ->
          conn
          |> put_status(422)
          |> render(ErrorView, "422.json", %{errors: errors})
    end
  end

  def delete(conn, %{"id" => uuid}) do
    with user = %User{} <- Repo.get(User, uuid) do
      Repo.delete!(user)

      conn
      |> Conn.put_status(204)
      |> Conn.send_resp(:no_content, "")
    else
      nil ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", error: "Not found")
    end
end
end
