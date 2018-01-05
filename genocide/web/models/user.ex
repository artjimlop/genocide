defmodule Genocide.User do
  use Genocide.Web, :model

  @derive {Poison.Encoder, only: [:username, :email]}
  @primary_key {:uuid, :binary_id, [autogenerate: true]}

  schema "users" do
    field :username, :string
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uuid, :username, :email, :provider, :token])
    |> validate_required([:username, :email, :provider, :token])
  end
end
