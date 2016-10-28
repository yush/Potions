defmodule CookBook.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user, :string
      add :email, :string
      add :password_digest, :string

      timestamps()
    end

  end
end
