defmodule CookBook.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :uploadDate, :date
      add :file, :string

      timestamps()
    end

  end
end
