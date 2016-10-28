defmodule CookBook.Recipe do
  use CookBook.Web, :model
  use Arc.Ecto.Schema

  schema "recipes" do
    field :name, :string
    field :uploadDate, Ecto.Date
    field :file, CookBook.Image.Type

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :uploadDate])
    |> cast_attachments(params, [:file])
    |> validate_required([:name, :uploadDate, :file])
  end
end
