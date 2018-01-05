defmodule Genocide.UserView do
  use Genocide.Web, :view

  def render("index.json", %{users: users}) do
    render_many(users, Genocide.UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, Genocide.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      uuid: user.uuid,
      username: user.username,
      email: user.email,
      provider: user.provider,
      token: user.token,
    }
  end
end
