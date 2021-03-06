defmodule CookBook.User do
  use CookBook.Web, :model
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :user, :string
    field :email, :string
    field :password_digest, :string
    timestamps

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    has_many :recipes, CookBook.Recipe 
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user, :email, :password, :password_confirmation])
    |> validate_required([:user, :email, :password, :password_confirmation])
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, hashpwsalt(password))
    else
      changeset
    end
  end
end
